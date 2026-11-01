import SwiftUI

struct LogoView: View {
    var tamanho: CGFloat = 64
    var claro: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "wrench.and.screwdriver.fill")
                .font(.system(size: tamanho))
                .foregroundStyle(claro ? Color.white : Tema.primaria)
            (Text("Servi").foregroundColor(claro ? .white : Tema.primaria)
             + Text("Moz").foregroundColor(Tema.destaque))
                .font(.system(size: tamanho * 0.6, weight: .bold))
        }
    }
}

struct SplashView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(hex: 0x4A2BD6), Color(hex: 0x2E1A9E)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                LogoView(tamanho: 80, claro: true)
                Text("Conectando pessoas\naos melhores serviços")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                ProgressView()
                    .tint(.white)
                    .padding(.top, 30)
            }
        }
    }
}
