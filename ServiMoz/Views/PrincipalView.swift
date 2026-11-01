import SwiftUI

struct PrincipalView: View {
    @Environment(Sessao.self) private var sessao

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 60))
                .foregroundStyle(.green)
            Text("Bem-vindo, \(sessao.utilizador?.nome ?? "")!")
                .font(.title2.bold())
            Text("Perfil: \(sessao.utilizador?.tipo.rawValue ?? "")")
                .foregroundStyle(.secondary)
            Button("Terminar sessão") {
                sessao.utilizador = nil
            }
            .buttonStyle(.secundario)
            .padding(.horizontal, 40)
        }
    }
}
