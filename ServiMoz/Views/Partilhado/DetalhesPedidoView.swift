import SwiftUI
import SwiftData

struct DetalhesPedidoView: View {
    let pedido: Pedido

    @Environment(\.modelContext) private var contexto
    @Environment(Sessao.self) private var sessao

    private var ehPrestador: Bool {
        sessao.utilizador?.tipo == .prestador
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Spacer()
                    EstadoBadge(estado: pedido.estado)
                }

                linha(icone: "person.fill", titulo: ehPrestador ? "Cliente" : "Prestador",
                      valor: ehPrestador ? pedido.clienteNome : pedido.prestadorNome)
                linha(icone: pedido.categoria.icone, titulo: "Serviço", valor: pedido.descricao)
                linha(icone: "calendar", titulo: "Data e Hora",
                      valor: pedido.data.formatted(date: .numeric, time: .shortened))
                linha(icone: "mappin.and.ellipse", titulo: "Localização", valor: pedido.local)

                if pedido.avaliado {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Avaliação").font(.headline)
                        EstrelasView(nota: Double(pedido.notaAvaliacao), tamanho: 20)
                        if !pedido.comentario.isEmpty {
                            Text(pedido.comentario)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .cartao()
                }

                botoes
                    .padding(.top, 8)
            }
            .padding()
        }
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle("Detalhes do Pedido")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func linha(icone: String, titulo: String, valor: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icone)
                .foregroundStyle(Tema.primaria)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(titulo)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(valor)
                    .font(.body)
            }
            Spacer()
        }
        .padding(14)
        .cartao()
    }

    @ViewBuilder
    private var botoes: some View {
        if ehPrestador {
            VStack(spacing: 10) {
                if pedido.estado == .pendente {
                    Button("Aceitar") {
                        mudar(.aceite, titulo: "Pedido aceite",
                              mensagem: "\(pedido.prestadorNome) aceitou o seu pedido.",
                              icone: "bell.fill")
                    }
                    .buttonStyle(.primario)
                    Button("Recusar") {
                        mudar(.recusado, titulo: "Pedido recusado",
                              mensagem: "\(pedido.prestadorNome) recusou o seu pedido.",
                              icone: "xmark.circle.fill")
                    }
                    .buttonStyle(.secundario)
                }
                if pedido.estado == .aceite {
                    Button("Atualizar Estado (iniciar serviço)") {
                        mudar(.emAndamento, titulo: "Pedido atualizado",
                              mensagem: "O prestador iniciou o seu serviço.",
                              icone: "bell.fill")
                    }
                    .buttonStyle(.secundario)
                }
                if pedido.estado == .aceite || pedido.estado == .emAndamento {
                    Button("Marcar como Concluído") {
                        mudar(.concluido, titulo: "Serviço concluído",
                              mensagem: "Parabéns! O seu serviço foi concluído. Avalie o prestador.",
                              icone: "checkmark.circle.fill")
                    }
                    .buttonStyle(.primario)
                }
            }
        } else if pedido.estado == .concluido && !pedido.avaliado {
            NavigationLink {
                AvaliacaoView(pedido: pedido)
            } label: {
                Label("Avaliar Serviço", systemImage: "star.fill")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Tema.primaria, in: RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    // Muda o estado e avisa o cliente com uma notificação.
    private func mudar(_ novo: EstadoPedido, titulo: String, mensagem: String, icone: String) {
        pedido.estado = novo
        contexto.insert(Notificacao(
            titulo: titulo,
            mensagem: mensagem,
            icone: icone,
            destinatario: pedido.clienteNome
        ))
        try? contexto.save()
    }
}
