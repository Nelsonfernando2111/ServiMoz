import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(Sessao.self) private var sessao
    @Query private var utilizadores: [Utilizador]

    @State private var modoRegisto = false
    @State private var nome = ""
    @State private var contacto = ""
    @State private var senha = ""
    @State private var mostrarSenha = false
    @State private var mensagemErro: String?
    @State private var irParaPerfil = false
    @State private var mostrarAviso = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    LogoView(tamanho: 64)
                        .padding(.top, 30)

                    Text(modoRegisto ? "Crie a sua conta" : "Entre ou crie sua conta")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)

                    if modoRegisto {
                        campo(icone: "person") {
                            TextField("Nome completo", text: $nome)
                        }
                    }

                    campo(icone: "envelope") {
                        TextField("E-mail ou Telefone", text: $contacto)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }

                    campo(icone: "lock") {
                        HStack {
                            if mostrarSenha {
                                TextField("Senha", text: $senha)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            } else {
                                SecureField("Senha", text: $senha)
                            }
                            Button {
                                mostrarSenha.toggle()
                            } label: {
                                Image(systemName: mostrarSenha ? "eye" : "eye.slash")
                                    .foregroundStyle(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    if let mensagemErro {
                        Text(mensagemErro)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }

                    Button(modoRegisto ? "Continuar" : "Entrar") {
                        if modoRegisto { registar() } else { entrar() }
                    }
                    .buttonStyle(.primario)
                    .padding(.top, 4)

                    HStack {
                        Rectangle().fill(.quaternary).frame(height: 1)
                        Text("ou").font(.footnote).foregroundStyle(.secondary)
                        Rectangle().fill(.quaternary).frame(height: 1)
                    }
                    .padding(.vertical, 6)

                    HStack(spacing: 12) {
                        Button { mostrarAviso = true } label: {
                            Label("Google", systemImage: "globe")
                        }
                        .buttonStyle(.secundario)

                        Button { mostrarAviso = true } label: {
                            Label("Apple", systemImage: "apple.logo")
                        }
                        .buttonStyle(.secundario)
                    }

                    HStack(spacing: 4) {
                        Text(modoRegisto ? "Já tem conta?" : "Não tem conta?")
                        Button(modoRegisto ? "Entrar" : "Registe-se") {
                            modoRegisto.toggle()
                            mensagemErro = nil
                        }
                        .fontWeight(.semibold)
                        .foregroundStyle(Tema.primaria)
                    }
                    .font(.footnote)
                    .padding(.top, 10)
                }
                .padding(.horizontal, 24)
            }
            .background(Tema.fundo.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $irParaPerfil) {
                EscolhaPerfilView(nome: nome, contacto: contacto, senha: senha)
            }
            .alert("Indisponível", isPresented: $mostrarAviso) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("O acesso com Google e Apple não faz parte do MVP. Use e-mail ou telefone.")
            }
        }
    }

    // Campo de texto com ícone e fundo arredondado.
    private func campo<Conteudo: View>(icone: String, @ViewBuilder conteudo: () -> Conteudo) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icone)
                .foregroundStyle(.secondary)
                .frame(width: 22)
            conteudo()
        }
        .padding(14)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray5)))
    }

    private func entrar() {
        let c = contacto.trimmingCharacters(in: .whitespaces).lowercased()
        if let u = utilizadores.first(where: { $0.contacto.lowercased() == c && $0.senha == senha }) {
            sessao.utilizador = u
        } else {
            mensagemErro = "Contacto ou senha incorretos."
        }
    }

    private func registar() {
        let n = nome.trimmingCharacters(in: .whitespaces)
        let c = contacto.trimmingCharacters(in: .whitespaces)

        if n.isEmpty || c.isEmpty {
            mensagemErro = "Preencha o nome e o contacto."
        } else if senha.count < 4 {
            mensagemErro = "A senha deve ter pelo menos 4 caracteres."
        } else if utilizadores.contains(where: { $0.contacto.lowercased() == c.lowercased() }) {
            mensagemErro = "Já existe uma conta com este contacto."
        } else {
            mensagemErro = nil
            nome = n
            contacto = c
            irParaPerfil = true
        }
    }
}
