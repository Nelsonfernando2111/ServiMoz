import SwiftUI

struct PrincipalView: View {
    @Environment(Sessao.self) private var sessao

    var body: some View {
        if sessao.utilizador?.tipo == .prestador {
            PrestadorTabView()
        } else {
            ClienteTabView()
        }
    }
}
