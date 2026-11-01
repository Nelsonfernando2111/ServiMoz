import Foundation
import SwiftData

enum DadosIniciais {
    static func carregar(contexto: ModelContext) {
        let existentes = (try? contexto.fetchCount(FetchDescriptor<Prestador>())) ?? 0
        guard existentes == 0 else { return }

        let lista: [Prestador] = [
            Prestador(nome: "João Manuel", categoria: .canalizacao, cidade: "Maputo", precoDesde: 500,
                      descricao: "Especialista em canalização com experiência de mais de 5 anos.",
                      anosExperiencia: 5, telefone: "841234567", nota: 4.7, numAvaliacoes: 124,
                      servicos: ["Canalização", "Reparação", "Instalação"]),
            Prestador(nome: "Carlos Alberto", categoria: .canalizacao, cidade: "Maputo", precoDesde: 600,
                      descricao: "Reparações e instalações de canalização para casas e escritórios.",
                      anosExperiencia: 8, telefone: "842345678", nota: 4.5, numAvaliacoes: 98,
                      servicos: ["Canalização", "Reparação", "Instalação"]),
            Prestador(nome: "Manuel Silva", categoria: .canalizacao, cidade: "Matola", precoDesde: 550,
                      descricao: "Canalizador com atendimento rápido na Matola e arredores.",
                      anosExperiencia: 4, telefone: "843456789", nota: 4.3, numAvaliacoes: 76,
                      servicos: ["Canalização", "Reparação"]),
            Prestador(nome: "Américo Tembe", categoria: .electricidade, cidade: "Maputo", precoDesde: 700,
                      descricao: "Instalações eléctricas, quadros e reparação de avarias.",
                      anosExperiencia: 10, telefone: "844567890", nota: 4.8, numAvaliacoes: 143,
                      servicos: ["Instalação", "Reparação", "Quadros eléctricos"]),
            Prestador(nome: "Paulo Cossa", categoria: .electricidade, cidade: "Matola", precoDesde: 650,
                      descricao: "Electricista com experiência em habitações e comércio.",
                      anosExperiencia: 6, telefone: "845678901", nota: 4.4, numAvaliacoes: 61,
                      servicos: ["Instalação", "Reparação"]),
            Prestador(nome: "Ana Machava", categoria: .limpeza, cidade: "Maputo", precoDesde: 400,
                      descricao: "Limpeza doméstica e de escritórios, com produtos incluídos.",
                      anosExperiencia: 7, telefone: "846789012", nota: 4.9, numAvaliacoes: 187,
                      servicos: ["Limpeza geral", "Limpeza pós-obra"]),
            Prestador(nome: "Sónia Mondlane", categoria: .limpeza, cidade: "Matola", precoDesde: 350,
                      descricao: "Limpeza de casas e apartamentos com horário flexível.",
                      anosExperiencia: 3, telefone: "847890123", nota: 4.2, numAvaliacoes: 39,
                      servicos: ["Limpeza geral"]),
            Prestador(nome: "Fernando Sitoe", categoria: .transportes, cidade: "Maputo", precoDesde: 800,
                      descricao: "Transporte de mobília e mudanças com carrinha própria.",
                      anosExperiencia: 9, telefone: "848901234", nota: 4.6, numAvaliacoes: 85,
                      servicos: ["Mudanças", "Transporte de carga"]),
            Prestador(nome: "Rui Bila", categoria: .transportes, cidade: "Matola", precoDesde: 750,
                      descricao: "Transporte de mercadorias e pequenas mudanças.",
                      anosExperiencia: 5, telefone: "849012345", nota: 4.1, numAvaliacoes: 28,
                      servicos: ["Transporte de carga"])
        ]

        for p in lista {
            contexto.insert(p)
        }
    }
}
