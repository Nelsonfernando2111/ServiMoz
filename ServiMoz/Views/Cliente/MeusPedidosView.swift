import SwiftUI
import SwiftData

enum FiltroPedidos: String, CaseIterable {
    case todos = "Todos"
    case andamento = "Em andamento"
    case concluidos = "Concluídos"
}

struct MeusPedidosView: View {
    @Environment(Sessao.self) private var sessao
    @Query(sort: \Pedido.criadoEm, order: .reverse) private var todos: [Pedido]

    @State private var filtro: FiltroPedidos = .todos

    private var pedidos: [Pedido] {
        let nome = sessao.utilizador?.nome ?? ""
        let meus = todos.filter { $0.clienteNome == nome }
        switch filtro {
        case .todos:
            return meus
        case .andamento:
            return meus.filter { $0.estado == .pendente || $0.estado == .aceite || $0.estado == .emAndamento }
        case .concluidos:
            return meus.filter { $0.estado == .concluido }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("Filtro", selection: $filtro) {
                    ForEach(FiltroPedidos.allCases, id: \.self) { f in
                        Text(f.rawValue).tag(f)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                if pedidos.isEmpty {
                    ContentUnavailableView(
                        "Sem pedidos",
                        systemImage: "tray",
                        description: Text("Os pedidos que fizer aparecem aqui.")
                    )
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(pedidos) { p in
                                NavigationLink {
                                    DetalhesPedidoView(pedido: p)
                                } label: {
                                    linha(p)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .background(Tema.fundo.ignoresSafeArea())
            .navigationTitle("Meus Pedidos")
        }
    }

    private func linha(_ p: Pedido) -> some View {
        HStack(spacing: 12) {
            Image(systemName: p.categoria.icone)
                .font(.title2)
                .foregroundStyle(p.categoria.cor)
                .frame(width: 52, height: 52)
                .background(p.categoria.cor.opacity(0.15), in: RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(p.descricao)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                EstadoBadge(estado: p.estado)
                Label(p.data.formatted(date: .numeric, time: .shortened), systemImage: "calendar")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(p.prestadorNome)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .cartao()
    }
}
