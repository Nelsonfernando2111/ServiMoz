import SwiftUI

// Círculo com as iniciais (substitui as fotos do design).
struct AvatarView: View {
    let iniciais: String
    var tamanho: CGFloat = 52
    var cor: Color = Tema.primaria

    var body: some View {
        Text(iniciais)
            .font(.system(size: tamanho * 0.36, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: tamanho, height: tamanho)
            .background(cor.gradient, in: Circle())
    }
}

// Estrelas só para mostrar (ex.: nota 4.7 mostra 5 estrelas, 4 cheias).
struct EstrelasView: View {
    let nota: Double
    var tamanho: CGFloat = 14

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: Double(i) <= nota.rounded() ? "star.fill" : "star")
                    .font(.system(size: tamanho))
                    .foregroundStyle(Tema.destaque)
            }
        }
    }
}

// Estrelas que o utilizador toca para avaliar.
struct EstrelasSelector: View {
    @Binding var nota: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: i <= nota ? "star.fill" : "star")
                    .font(.system(size: 36))
                    .foregroundStyle(Tema.destaque)
                    .onTapGesture { nota = i }
            }
        }
    }
}

// Etiqueta colorida com o estado do pedido.
struct EstadoBadge: View {
    let estado: EstadoPedido

    var body: some View {
        Text(estado.rawValue)
            .font(.caption.bold())
            .foregroundStyle(estado.cor)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(estado.cor.opacity(0.15), in: Capsule())
    }
}

// Cartão do prestador, usado em Home e Resultados.
struct CartaoPrestador: View {
    let prestador: Prestador

    var body: some View {
        HStack(spacing: 12) {
            AvatarView(iniciais: prestador.iniciais, tamanho: 60, cor: prestador.categoria.cor)

            VStack(alignment: .leading, spacing: 3) {
                Text(prestador.nome)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(prestador.categoria.profissao)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundStyle(Tema.destaque)
                    Text("\(prestador.nota, specifier: "%.1f") (\(prestador.numAvaliacoes))")
                        .font(.caption)
                        .foregroundStyle(.primary)
                }
                Label(prestador.cidade, systemImage: "mappin.and.ellipse")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("A partir de")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Text(prestador.precoDesde.emMT)
                    .font(.subheadline.bold())
                    .foregroundStyle(Tema.primaria)
            }
        }
        .padding(12)
        .cartao()
    }
}
