import SwiftUI
import SwiftData

struct NotificacoesView: View {
    @Environment(Sessao.self) private var sessao
    @Query(sort: \Notificacao.data, order: .reverse) private var todas: [Notificacao]

    private var minhas: [Notificacao] {
        let nome = sessao.utilizador?.nome ?? ""
        return todas.filter { $0.destinatario == nome }
    }

    var body: some View {
        Group {
            if minhas.isEmpty {
                ContentUnavailableView(
                    "Sem notificações",
                    systemImage: "bell.slash",
                    description: Text("As alterações nos seus pedidos aparecem aqui.")
                )
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(minhas) { n in
                            HStack(alignment: .top, spacing: 12) {
                                Image(systemName: n.icone)
                                    .foregroundStyle(Tema.primaria)
                                    .frame(width: 40, height: 40)
                                    .background(Tema.primariaClara, in: Circle())
                                VStack(alignment: .leading, spacing: 3) {
                                    HStack {
                                        Text(n.titulo).font(.headline)
                                        Spacer()
                                        Text(n.data, style: .relative)
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                    Text(n.mensagem)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .cartao()
                        }
                    }
                    .padding()
                }
            }
        }
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle("Notificações")
        .navigationBarTitleDisplayMode(.inline)
    }
}
