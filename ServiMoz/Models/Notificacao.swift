import Foundation
import SwiftData

@Model
final class Notificacao {
    var titulo: String
    var mensagem: String
    var data: Date
    var icone: String          // nome do SF Symbol
    var destinatario: String   // nome do utilizador que recebe

    init(titulo: String, mensagem: String, icone: String, destinatario: String, data: Date = .now) {
        self.titulo = titulo
        self.mensagem = mensagem
        self.icone = icone
        self.destinatario = destinatario
        self.data = data
    }
}
