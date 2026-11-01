import Foundation
import SwiftData

@Model
final class Pedido {
    var id: UUID
    var descricao: String
    var data: Date              // data e hora pretendidas
    var local: String
    var estado: EstadoPedido
    var clienteNome: String
    var prestadorID: UUID
    var prestadorNome: String
    var categoria: Categoria
    var criadoEm: Date
    var avaliado: Bool
    var notaAvaliacao: Int
    var comentario: String

    init(descricao: String, data: Date, local: String, clienteNome: String,
         prestadorID: UUID, prestadorNome: String, categoria: Categoria) {
        self.id = UUID()
        self.descricao = descricao
        self.data = data
        self.local = local
        self.estado = .pendente
        self.clienteNome = clienteNome
        self.prestadorID = prestadorID
        self.prestadorNome = prestadorNome
        self.categoria = categoria
        self.criadoEm = .now
        self.avaliado = false
        self.notaAvaliacao = 0
        self.comentario = ""
    }
}
