import Foundation
import SwiftData

@Model
final class Utilizador {
    var nome: String
    var contacto: String   // e-mail ou telefone
    var senha: String
    var tipo: TipoUtilizador

    init(nome: String, contacto: String, senha: String, tipo: TipoUtilizador) {
        self.nome = nome
        self.contacto = contacto
        self.senha = senha
        self.tipo = tipo
    }
}
