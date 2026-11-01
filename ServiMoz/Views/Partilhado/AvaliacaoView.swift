import SwiftUI
import SwiftData

struct AvaliacaoView: View {
    let pedido: Pedido

    @Environment(\.modelContext) private var contexto
    @Environment(\.dismiss) private var dismiss
    @Query private var prestadores: [Prestador]

    @State private var nota = 0
    @State private var comentario = ""
    @State private var mostrarSucesso = false

    var body: some View {
        VStack(spacing: 18) {
            Image(systemName: "star.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(Tema.primaria)
                .padding(.top, 20)

            Text("Avaliar Serviço")
                .font(.title2.bold())
            Text("Como você avalia o serviço de \(pedido.prestadorNome)?")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            EstrelasSelector(nota: $nota)

            TextField("Deixe um comentário...", text: $comentario, axis: .vertical)
                .lineLimit(3...5)
                .padding(14)
                .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12))
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray5)))

            Button("Enviar Avaliação") { enviar() }
                .buttonStyle(.primario)
                .disabled(nota == 0)

            Spacer()
        }
        .padding(24)
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle("Avaliação")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Obrigado!", isPresented: $mostrarSucesso) {
            Button("OK") { dismiss() }
        } message: {
            Text("A sua avaliação foi enviada.")
        }
    }

    private func enviar() {
        // Só serviços concluídos podem ser avaliados (regra de negócio).
        guard pedido.estado == .concluido, !pedido.avaliado else { return }

        pedido.avaliado = true
        pedido.notaAvaliacao = nota
        pedido.comentario = comentario.trimmingCharacters(in: .whitespaces)

        // Actualiza a nota média do prestador.
        if let p = prestadores.first(where: { $0.id == pedido.prestadorID }) {
            let total = p.nota * Double(p.numAvaliacoes) + Double(nota)
            p.numAvaliacoes += 1
            p.nota = total / Double(p.numAvaliacoes)
        }

        contexto.insert(Notificacao(
            titulo: "Nova avaliação",
            mensagem: "Você recebeu uma avaliação de \(nota) estrelas.",
            icone: "star.fill",
            destinatario: pedido.prestadorNome
        ))

        try? contexto.save()
        mostrarSucesso = true
    }
}
