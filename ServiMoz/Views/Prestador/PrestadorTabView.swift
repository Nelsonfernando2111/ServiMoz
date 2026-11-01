import SwiftUI

struct PrestadorTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                PedidosRecebidosView()
            }
            .tabItem { Label("Pedidos", systemImage: "list.clipboard") }

            NavigationStack {
                NotificacoesView()
            }
            .tabItem { Label("Notificações", systemImage: "bell.fill") }

            PerfilUtilizadorView()
                .tabItem { Label("Perfil", systemImage: "person.fill") }
        }
        .tint(Tema.primaria)
    }
}
