import SwiftUI
import SwiftData

struct ResultadosView: View {
    let titulo: String

    @Query(sort: \Prestador.nota, order: .reverse) private var todos: [Prestador]

    @State private var texto: String
    @State private var cidade = "Todas"
    @State private var categoriaFiltro: Categoria?
    @State private var apenasDisponiveis = false

    private let cidades = ["Todas", "Maputo", "Matola"]

    init(categoria: Categoria? = nil, textoInicial: String = "", titulo: String = "Resultados") {
        self.titulo = titulo
        _texto = State(initialValue: textoInicial)
        _categoriaFiltro = State(initialValue: categoria)
    }

    private func corresponde(_ p: Prestador) -> Bool {
        if let categoriaFiltro, p.categoria != categoriaFiltro { return false }
        if cidade != "Todas", p.cidade != cidade { return false }
        if apenasDisponiveis, !p.disponivel { return false }

        let t = texto.trimmingCharacters(in: .whitespaces)
        if t.isEmpty { return true }
        if p.nome.localizedStandardContains(t) { return true }
        if p.categoria.rawValue.localizedStandardContains(t) { return true }
        if p.categoria.profissao.localizedStandardContains(t) { return true }
        return p.servicos.contains { $0.localizedStandardContains(t) }
    }

    private var resultados: [Prestador] {
        todos.filter { corresponde($0) }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                barraFiltros

                Text("\(resultados.count) prestadores encontrados")
                    .font(.footnote)
                    .foregroundStyle(.secondary)

                if resultados.isEmpty {
                    ContentUnavailableView(
                        "Sem resultados",
                        systemImage: "magnifyingglass",
                        description: Text("Tente outra pesquisa ou retire alguns filtros.")
                    )
                } else {
                    ForEach(resultados) { p in
                        NavigationLink {
                            PerfilPrestadorView(prestador: p)
                        } label: {
                            CartaoPrestador(prestador: p)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
        .background(Tema.fundo.ignoresSafeArea())
        .navigationTitle(titulo)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $texto, prompt: "Pesquisar serviços...")
    }

    private var barraFiltros: some View {
        HStack {
            Menu {
                Picker("Cidade", selection: $cidade) {
                    ForEach(cidades, id: \.self) { c in
                        Text(c).tag(c)
                    }
                }
            } label: {
                Label(cidade, systemImage: "mappin.and.ellipse")
                    .font(.subheadline)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5)))
            }

            Spacer()

            Menu {
                Toggle("Apenas disponíveis", isOn: $apenasDisponiveis)
                Picker("Categoria", selection: $categoriaFiltro) {
                    Text("Todas").tag(Optional<Categoria>.none)
                    ForEach(Categoria.allCases) { c in
                        Text(c.rawValue).tag(Optional(c))
                    }
                }
            } label: {
                Label("Filtros", systemImage: "line.3.horizontal.decrease")
                    .font(.subheadline)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5)))
            }
        }
        .foregroundStyle(.primary)
    }
}
