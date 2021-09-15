//
//  MovieListView.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 7/9/21.
//

import SwiftUI

struct MovieListView: View {
    var movies: [MovieCellVO] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    NavigationLink(destination: Text("blabla")) {
                        MovieCellUI(vo: movie)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarSearch($searchText)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        let dto = MovieDTO(id: 1, title: "El Club de la Lucha", overview: "This is an overview muy muy largo y tal y cual asdf adsf asdf as df asdf asdf asd f", poster: "https://picsum.photos/id/43/3000", releaseDate: "2020-01-01", genres: nil)
        let movie = Movie(from: dto)
        let vo = MovieCellVO(from: movie)
        
        let dto2 = MovieDTO(id: 1, title: "El Rey León", overview: "This is an overview muy muy largo y tal y cual asdf adsf asdf as df asdf asdf asd f", poster: "https://picsum.photos/id/43/3000", releaseDate: "2020-01-01", genres: nil)
        let movie2 = Movie(from: dto2)
        let vo2 = MovieCellVO(from: movie2)
        
        MovieListView(movies: [vo, vo2])
    }
}
