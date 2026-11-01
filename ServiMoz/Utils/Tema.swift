import SwiftUI

extension Color {
    // Permite escrever cores em hexadecimal: Color(hex: 0x4A2BD6)
    init(hex: UInt32) {
        let r = Double((hex >> 16) & 0xFF) / 255
        let g = Double((hex >> 8) & 0xFF) / 255
        let b = Double(hex & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}

enum Tema {
    static let primaria = Color(hex: 0x4A2BD6)
    static let primariaClara = Color(hex: 0xEEEAFE)
    static let fundo = Color(hex: 0xF6F4FF)
    static let destaque = Color(hex: 0xF5A623)
}

extension View {
    // Cartão branco com cantos arredondados e sombra suave.
    func cartao() -> some View {
        self
            .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
    }
}
