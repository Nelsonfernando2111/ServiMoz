import SwiftUI
import SwiftData

struct RaizView: View {
    @Environment(\.modelContext) private var contexto
    @Environment(Sessao.self) private var sessao
    @State private var mostrarSplash = true

    var body: some View {
        ZStack {
            if mostrarSplash {
                SplashView()
            } else if sessao.utilizador != nil {
                PrincipalView()
            } else {
                LoginView()
            }
        }
        .task {
            DadosIniciais.carregar(contexto: contexto)
            try? await Task.sleep(for: .seconds(2))
            withAnimation { mostrarSplash = false }
        }
    }
}
