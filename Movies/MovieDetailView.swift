//
//  MovieDetailView.swift
//  Movies
//
//  Created by Carlos Machado on 10/04/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment:.top){
            ZStack{
                if let backdropPath = movie.backdropPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    ZStack{
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: 320)
                    .background(.gray)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 320)
            .clipped()
            .mask(LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom))
            .opacity(0.5)
            
            ScrollView{
                VStack(alignment: .leading) {
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
                    .padding(EdgeInsets(top: 160, leading: 16, bottom: 0, trailing: 0))
                    .shadow(radius: 6, x:0, y:10)
                    
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.largeTitle.bold())
                            Text(movie.releaseDate.prefix(4))
                                .font(.subheadline)
                                .opacity(0.5)
                        }.padding()
                        Spacer()
                        HStack(spacing: 4) {
                            Text(String(movie.voteAverage))
                                .font(.body)
                            Image(systemName: "star.fill")
                                .resizable()
                                .foregroundColor(.yellow)
                                .frame(width: 12, height:12)
                        }.padding()
                    }
                    Text(movie.overview)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            }
            
        }
        
        Button(action: {
            dismiss()
        }) {
            Text("Fechar")
                .padding(10)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.bordered)
    }
}
