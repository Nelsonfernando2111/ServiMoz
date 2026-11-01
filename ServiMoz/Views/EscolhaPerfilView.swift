import SwiftUI
import SwiftData

struct EscolhaPerfilView: View {
    let nome: String
    let contacto: String
    let senha: String

    @Environment(\.modelContext) private var contexto
    @Environment(Sessao.self) private var sessao

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Escolha o seu perfil")
                .font(.title.bold())
            Text("Como você vai usar o ServiMoz?")
                .foregroundStyle(.secondary)
                .padding(.bottom, 8)

            cartaoPerfil(tipo: .cliente, icone: "person.2.fill", subtitulo: "Procuro serviços")
            cartaoPerfil(tipo: .prestador, icone: "briefcase.fill", subtitulo: "Disponibilizo serviços")

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Tema.fundo.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
    }

    private func cartaoPerfil(tipo: TipoUtilizador, icone: String, subtitulo: String) -> some View {
        Button {
            criarConta(tipo: tipo)
        } label: {
            HStack(spacing: 14) {
                Image(systemName: icone)
                    .font(.title2)
                    .foregroundStyle(Tema.primaria)
                    .frame(width: 56, height: 56)
                    .background(Tema.primariaClara, in: Circle())

                VStack(alignment: .leading, spacing: 2) {
                    Text(tipo.rawValue)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Text(subtitulo)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }
            .padding(14)
            .cartao()
        }
        .buttonStyle(.plain)
    }

    private func criarConta(tipo: TipoUtilizador) {
        let u = Utilizador(nome: nome, contacto: contacto, senha: senha, tipo: tipo)
        contexto.insert(u)
        try? contexto.save()
        sessao.utilizador = u
    }
}
