import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \Prestador.nota, order: .reverse) private var prestadores: [Prestador]
    @State private var pesquisa = ""
    @State private var mostrarResultados = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    cabecalho
                    campoPesquisa
                    banner
                    categorias
                    destaque
                }
                .padding()
            }
            .background(Tema.fundo.ignoresSafeArea())
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $mostrarResultados) {
                ResultadosView(textoInicial: pesquisa)
            }
        }
    }

    private var cabecalho: some View {
        HStack(spacing: 8) {
            Image(systemName: "wrench.and.screwdriver.fill")
                .foregroundStyle(Tema.primaria)
            (Text("Servi").foregroundColor(Tema.primaria) + Text("Moz").foregroundColor(Tema.destaque))
                .font(.title3.bold())
            Spacer()
            NavigationLink {
                NotificacoesView()
            } label: {
                Image(systemName: "bell.fill")
                    .font(.title3)
                    .foregroundStyle(Tema.primaria)
            }
        }
    }

    private var campoPesquisa: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Pesquisar serviços...", text: $pesquisa)
                .submitLabel(.search)
                .onSubmit { mostrarResultados = true }
        }
        .padding(14)
        .background(Color(.systemBackground), in: RoundedRectangle(cornerRadius: 12))
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color(.systemGray5)))
    }

    private var banner: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Encontre profissionais\nconfiáveis perto de si")
                .font(.title3.bold())
                .foregroundStyle(.white)
            Button {
                mostrarResultados = true
            } label: {
                Text("Buscar agora")
                    .font(.subheadline.bold())
                    .foregroundStyle(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Tema.destaque, in: RoundedRectangle(cornerRadius: 10))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            LinearGradient(colors: [Color(hex: 0x4A2BD6), Color(hex: 0x2E1A9E)],
                           startPoint: .topLeading, endPoint: .bottomTrailing),
            in: RoundedRectangle(cornerRadius: 18)
        )
    }

    private var categorias: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Categorias")
                .font(.headline)
            HStack(spacing: 0) {
                ForEach(Categoria.allCases) { c in
                    NavigationLink {
                        ResultadosView(categoria: c)
                    } label: {
                        VStack(spacing: 6) {
                            Image(systemName: c.icone)
                                .font(.title2)
                                .foregroundStyle(c.cor)
                                .frame(width: 56, height: 56)
                                .background(c.cor.opacity(0.15), in: RoundedRectangle(cornerRadius: 14))
                            Text(c.rawValue)
                                .font(.caption2)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var destaque: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Prestadores em destaque")
                    .font(.headline)
                Spacer()
                NavigationLink("Ver todos") {
                    ResultadosView()
                }
                .font(.subheadline)
                .foregroundStyle(Tema.primaria)
            }
            ForEach(prestadores.prefix(3)) { p in
                NavigationLink {
                    PerfilPrestadorView(prestador: p)
                } label: {
                    CartaoPrestador(prestador: p)
                }
                .buttonStyle(.plain)
            }
        }
    }
}
