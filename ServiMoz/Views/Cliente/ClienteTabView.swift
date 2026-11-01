import SwiftUI

struct ClienteTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Início", systemImage: "house.fill") }

            NavigationStack {
                ResultadosView(titulo: "Pesquisa")
            }
            .tabItem { Label("Pesquisa", systemImage: "magnifyingglass") }

            MeusPedidosView()
                .tabItem { Label("Meus Pedidos", systemImage: "list.clipboard") }

            PerfilUtilizadorView()
                .tabItem { Label("Perfil", systemImage: "person.fill") }
        }
        .tint(Tema.primaria)
    }
}
