import Foundation
import SwiftData

@Model
final class Prestador {
    var id: UUID
    var nome: String
    var categoria: Categoria
    var cidade: String
    var precoDesde: Double
    var descricao: String
    var anosExperiencia: Int
    var disponivel: Bool
    var telefone: String
    var nota: Double
    var numAvaliacoes: Int
    var servicos: [String]

    init(nome: String, categoria: Categoria, cidade: String, precoDesde: Double,
         descricao: String, anosExperiencia: Int, disponivel: Bool = true,
         telefone: String, nota: Double, numAvaliacoes: Int, servicos: [String]) {
        self.id = UUID()
        self.nome = nome
        self.categoria = categoria
        self.cidade = cidade
        self.precoDesde = precoDesde
        self.descricao = descricao
        self.anosExperiencia = anosExperiencia
        self.disponivel = disponivel
        self.telefone = telefone
        self.nota = nota
        self.numAvaliacoes = numAvaliacoes
        self.servicos = servicos
    }

    // Iniciais para o avatar (ex.: "João Manuel" -> "JM").
    var iniciais: String {
        nome.split(separator: " ").prefix(2).compactMap { $0.first }.map { String($0) }.joined()
    }
}
