import SwiftUI

struct PerfilUtilizadorView: View {
    @Environment(Sessao.self) private var sessao

    var body: some View {
        NavigationStack {
            VStack(spacing: 14) {
                let nome = sessao.utilizador?.nome ?? ""
                AvatarView(iniciais: String(nome.split(separator: " ").prefix(2).compactMap { $0.first }),
                           tamanho: 90)
                    .padding(.top, 30)
                Text(nome)
                    .font(.title2.bold())
                Text(sessao.utilizador?.contacto ?? "")
                    .foregroundStyle(.secondary)
                Text(sessao.utilizador?.tipo.rawValue ?? "")
                    .font(.caption.bold())
                    .foregroundStyle(Tema.primaria)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(Tema.primariaClara, in: Capsule())

                Spacer()

                Button("Terminar sessão") {
                    sessao.utilizador = nil
                }
                .buttonStyle(.secundario)
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Tema.fundo.ignoresSafeArea())
            .navigationTitle("Perfil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
