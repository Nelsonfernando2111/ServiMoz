import SwiftUI
import SwiftData

@main
struct ServiMozApp: App {
    @State private var sessao = Sessao()

    var body: some Scene {
        WindowGroup {
            RaizView()
                .environment(sessao)
        }
        .modelContainer(for: [Utilizador.self, Prestador.self, Pedido.self, Notificacao.self])
    }
}
