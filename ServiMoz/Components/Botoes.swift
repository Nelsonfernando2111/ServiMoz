import SwiftUI

// Botão roxo cheio (ex.: "Entrar", "Enviar Pedido").
struct BotaoPrimarioStyle: ButtonStyle {
    @Environment(\.isEnabled) private var ativo

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                Tema.primaria.opacity(ativo ? (configuration.isPressed ? 0.8 : 1) : 0.4),
                in: RoundedRectangle(cornerRadius: 12)
            )
    }
}

// Botão com contorno roxo (ex.: "Recusar", "Atualizar Estado").
struct BotaoSecundarioStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Tema.primaria)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                Color(.systemBackground).opacity(configuration.isPressed ? 0.6 : 1),
                in: RoundedRectangle(cornerRadius: 12)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Tema.primaria, lineWidth: 1.5)
            )
    }
}

extension ButtonStyle where Self == BotaoPrimarioStyle {
    static var primario: BotaoPrimarioStyle { BotaoPrimarioStyle() }
}

extension ButtonStyle where Self == BotaoSecundarioStyle {
    static var secundario: BotaoSecundarioStyle { BotaoSecundarioStyle() }
}
