import SwiftUI
import SwiftData

struct PedidosRecebidosView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(Sessao.self) private var sessao
    @Query(sort: \Pedido.criadoEm, order: .reverse) private var todos: [Pedido]

    @State private var aba = 0

    private var meus: [Pedido] {
        let nome = sessao.utilizador?.nome ?? ""
        return todos.filter { $0.prestadorNome == nome }
    }

    private var novos: [Pedido] {
        meus.filter { $0.estado == .pendente }
    }

    private var aceites: [Pedido] {
        meus.filter { $0.estado == .aceite || $0.estado == .emAndamento || $0.estado == .concluido }
    }

    var body: some View {
        VStack(spacing: 0) {
            Picker("Aba", selection: $aba) {
                Text("Novos (\(novos.count))").tag(0)
                Text("Aceites").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()

            let lista = aba == 0 ? novos : aceites

            if lista.isEmpty {
                ContentUnavailableView(
                    "Sem pedidos",
                    systemImage: "tray",
                    description: Text("Os pedidos dos clientes aparecem aqui.")
                )
                .frame(maxHeight: .infinity)
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(lista) { p in
                            cartao(p)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle("Pedidos Recebidos")
    }

    private func cartao(_ p: Pedido) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            NavigationLink {
                DetalhesPedidoView(pedido: p)
            } label: {
                HStack(spacing: 12) {
                    AvatarView(
                        iniciais: String(p.clienteNome.split(separator: " ").prefix(2).compactMap { $0.first }),
                        tamanho: 48
                    )
                    VStack(alignment: .leading, spacing: 3) {
                        Text(p.clienteNome)
                            .font(.headline)
                            .foregroundStyle(.primary)
                        Text(p.descricao)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                        Label(p.data.formatted(date: .abbreviated, time: .shortened),
                              systemImage: "calendar")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Label(p.local, systemImage: "mappin.and.ellipse")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if p.estado != .pendente {
                        EstadoBadge(estado: p.estado)
                    }
                }
            }
            .buttonStyle(.plain)

            if p.estado == .pendente {
                HStack(spacing: 10) {
                    Button("Aceitar") { responder(p, aceitar: true) }
                        .buttonStyle(.primario)
                    Button("Recusar") { responder(p, aceitar: false) }
                        .buttonStyle(.secundario)
                }
            }
        }
        .padding(12)
        .cartao()
    }

    private func responder(_ p: Pedido, aceitar: Bool) {
        p.estado = aceitar ? .aceite : .recusado
        contexto.insert(Notificacao(
            titulo: aceitar ? "Pedido aceite" : "Pedido recusado",
            mensagem: aceitar
                ? "\(p.prestadorNome) aceitou o seu pedido."
                : "\(p.prestadorNome) recusou o seu pedido.",
            icone: aceitar ? "checkmark.circle.fill" : "xmark.circle.fill",
            destinatario: p.clienteNome
        ))
        try? contexto.save()
    }
}
