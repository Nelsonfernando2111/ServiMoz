import SwiftUI

enum TipoUtilizador: String, Codable, CaseIterable {
    case cliente = "Cliente"
    case prestador = "Prestador"
}

enum Categoria: String, Codable, CaseIterable, Identifiable {
    case canalizacao = "Canalização"
    case electricidade = "Electricidade"
    case limpeza = "Limpeza"
    case transportes = "Transportes"

    var id: String { rawValue }

    var icone: String {
        switch self {
        case .canalizacao: return "wrench.and.screwdriver"
        case .electricidade: return "bolt.fill"
        case .limpeza: return "sparkles"
        case .transportes: return "car.fill"
        }
    }

    var cor: Color {
        switch self {
        case .canalizacao: return .indigo
        case .electricidade: return .orange
        case .limpeza: return .purple
        case .transportes: return .blue
        }
    }

    // Nome da profissão, usado nos cartões dos prestadores.
    var profissao: String {
        switch self {
        case .canalizacao: return "Canalizador"
        case .electricidade: return "Electricista"
        case .limpeza: return "Limpeza"
        case .transportes: return "Transportador"
        }
    }
}

enum EstadoPedido: String, Codable, CaseIterable {
    case pendente = "Pendente"
    case aceite = "Aceite"
    case emAndamento = "Em andamento"
    case concluido = "Concluído"
    case recusado = "Recusado"

    var cor: Color {
        switch self {
        case .pendente: return .gray
        case .aceite: return .teal
        case .emAndamento: return .blue
        case .concluido: return .green
        case .recusado: return .red
        }
    }
}
