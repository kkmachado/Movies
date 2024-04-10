//
//  ContentView.swift
//  Movies
//
//  Created by Carlos Machado on 07/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var movies: [Movie] = []
    @State private var selectedMovie: Movie? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, onSearch: searchMovies)
                
                List(movies) { movie in
                    Button(action: {
                        selectedMovie = movie
                    }) {
                        HStack(alignment: .top, spacing: 16) {
                            VStack{
                                if let posterPath = movie.posterPath {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                } else {
                                    Image(systemName: "photo.on.rectangle.angled")
                                        .imageScale(.large)
                                        .opacity(0.25)
                                }
                            }
                            .frame(width: 80, height: 120)
                            .background(Color("CustomGray"))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .shadow(radius: 6, x:0, y:10)
                            
                            VStack(alignment: .leading){
                                Text(movie.title)
                                    .font(.headline.bold())
                                Text(movie.releaseDate.prefix(4))
                                    .font(.subheadline)
                                    .opacity(0.5)
                                Text(movie.overview)
                                    .font(.body)
                                    .lineLimit(3)
                                    .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                            HStack(spacing: 4) {
                                Text(String(movie.voteAverage))
                                    .font(.body)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .foregroundColor(.yellow)
                                    .frame(width: 12, height:12)
                            }
                        }.padding(EdgeInsets(top: 16, leading: 0, bottom: 8, trailing: 0))
                    }
                    
                }
                .scrollContentBackground(.hidden)
                .sheet(item: $selectedMovie) { movie in
                    MovieDetailView(movie: movie)
                }
            }
            .navigationTitle("Pesquisa de Filmes")
            .background(.gray.opacity(0.1))
        }
    }
    
    func searchMovies() {
        let apiKey = "e7ea89a7bb4aab0ba55a55890e5fe4f3"
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&adult=false&language=pt-BR&query=\(searchText)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(SearchResults.self, from: data)
                    DispatchQueue.main.async {
                        self.movies = result.results
                    }
                } catch let error {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct SearchResults: Codable {
    let results: [Movie]
}

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                TextField("Digite o nome do filme", text: $text, onCommit: onSearch)
                    .padding()
                    .submitLabel(.search)
                if !text.isEmpty { // Show clear button only when text is not empty
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "multiply.circle.fill").resizable()
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                    }.padding()
                }
            }
            .background(Color("CustomGray"))
            .cornerRadius(10)
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
