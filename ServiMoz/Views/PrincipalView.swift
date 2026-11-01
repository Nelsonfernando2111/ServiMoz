import SwiftUI

struct PrincipalView: View {
    @Environment(Sessao.self) private var sessao

    var body: some View {
        if sessao.utilizador?.tipo == .prestador {
            PrestadorProvisorioView()
        } else {
            ClienteTabView()
        }
    }
}

// Provisório: substituído no Passo 7.
struct PrestadorProvisorioView: View {
    @Environment(Sessao.self) private var sessao

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "briefcase.fill")
                .font(.system(size: 60))
                .foregroundStyle(Tema.primaria)
            Text("Olá, \(sessao.utilizador?.nome ?? "")!")
                .font(.title2.bold())
            Text("A área do prestador chega no próximo passo.")
                .foregroundStyle(.secondary)
            Button("Terminar sessão") {
                sessao.utilizador = nil
            }
            .buttonStyle(.secundario)
            .padding(.horizontal, 40)
        }
    }
}
