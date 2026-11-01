import SwiftUI

struct PerfilPrestadorView: View {
    let prestador: Prestador

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                HStack(spacing: 14) {
                    AvatarView(iniciais: prestador.iniciais, tamanho: 80, cor: prestador.categoria.cor)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 6) {
                            Text(prestador.nome)
                                .font(.title2.bold())
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(.blue)
                        }
                        HStack(spacing: 4) {
                            EstrelasView(nota: prestador.nota)
                            Text("\(prestador.nota, specifier: "%.1f") (\(prestador.numAvaliacoes) avaliações)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
                    Label(prestador.cidade, systemImage: "mappin.and.ellipse")
                    Label(prestador.categoria.profissao, systemImage: "briefcase")
                    Label(prestador.disponivel ? "Disponível hoje" : "Indisponível",
                          systemImage: "clock")
                    Label("A partir de \(prestador.precoDesde.emMT)", systemImage: "banknote")
                    Label("\(prestador.anosExperiencia) anos de experiência", systemImage: "medal")
                }
                .font(.subheadline)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Sobre").font(.headline)
                    Text(prestador.descricao)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Serviços").font(.headline)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(prestador.servicos, id: \.self) { s in
                                Text(s)
                                    .font(.caption)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Tema.primariaClara, in: Capsule())
                                    .foregroundStyle(Tema.primaria)
                            }
                        }
                    }
                }

                VStack(spacing: 10) {
                    NavigationLink {
                        SolicitarServicoView(prestador: prestador)
                    } label: {
                        Label("Solicitar Serviço", systemImage: "bubble.left.fill")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Tema.primaria, in: RoundedRectangle(cornerRadius: 12))
                    }

                    if let url = URL(string: "tel:\(prestador.telefone)") {
                        Link(destination: url) {
                            Label("Ligar: \(prestador.telefone)", systemImage: "phone.fill")
                                .font(.headline)
                                .foregroundStyle(Tema.primaria)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 14)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Tema.primaria, lineWidth: 1.5)
                                )
                        }
                    }
                }
                .padding(.top, 6)
            }
            .padding()
        }
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle("Perfil do Prestador")
        .navigationBarTitleDisplayMode(.inline)
    }
}
