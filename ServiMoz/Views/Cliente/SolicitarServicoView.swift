import SwiftUI
import SwiftData

struct SolicitarServicoView: View {
    let prestador: Prestador

    @Environment(\.modelContext) private var contexto
    @Environment(\.dismiss) private var dismiss
    @Environment(Sessao.self) private var sessao

    @State private var descricao = ""
    @State private var data = Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now
    @State private var local = ""
    @State private var mostrarSucesso = false

    private var valido: Bool {
        !descricao.trimmingCharacters(in: .whitespaces).isEmpty &&
        !local.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        Form {
            Section {
                HStack(spacing: 12) {
                    AvatarView(iniciais: prestador.iniciais, tamanho: 44, cor: prestador.categoria.cor)
                    VStack(alignment: .leading) {
                        Text(prestador.nome).font(.headline)
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundStyle(Tema.destaque)
                            Text("\(prestador.nota, specifier: "%.1f") (\(prestador.numAvaliacoes))")
                                .font(.caption)
                        }
                    }
                }
            }

            Section("Detalhes do Serviço") {
                TextField("Descrição do serviço", text: $descricao, axis: .vertical)
                    .lineLimit(2...4)
                DatePicker("Data e hora", selection: $data,
                           in: Date.now...,
                           displayedComponents: [.date, .hourAndMinute])
                TextField("Localização (ex.: Alto-Maé)", text: $local)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle("Solicitar Serviço")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            Button("Enviar Pedido") { enviar() }
                .buttonStyle(.primario)
                .disabled(!valido)
                .padding()
                .background(.bar)
        }
        .alert("Pedido enviado", isPresented: $mostrarSucesso) {
            Button("OK") { dismiss() }
        } message: {
            Text("O prestador vai receber o seu pedido. Acompanhe o estado em Meus Pedidos.")
        }
    }

    private func enviar() {
        let nomeCliente = sessao.utilizador?.nome ?? "Cliente"

        let pedido = Pedido(
            descricao: descricao.trimmingCharacters(in: .whitespaces),
            data: data,
            local: local.trimmingCharacters(in: .whitespaces),
            clienteNome: nomeCliente,
            prestadorID: prestador.id,
            prestadorNome: prestador.nome,
            categoria: prestador.categoria
        )
        contexto.insert(pedido)

        contexto.insert(Notificacao(
            titulo: "Novo pedido",
            mensagem: "\(nomeCliente) pediu: \(pedido.descricao)",
            icone: "bell.fill",
            destinatario: prestador.nome
        ))
        contexto.insert(Notificacao(
            titulo: "Pedido enviado",
            mensagem: "O seu pedido foi enviado a \(prestador.nome).",
            icone: "paperplane.fill",
            destinatario: nomeCliente
        ))

        try? contexto.save()
        mostrarSucesso = true
    }
}
