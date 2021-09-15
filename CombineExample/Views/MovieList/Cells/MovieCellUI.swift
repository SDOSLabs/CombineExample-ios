//
//  MovieCellUI.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 7/9/21.
//

import SwiftUI
import Combine

struct MovieCellUI: View {
    @ObservedObject var vo: MovieCellVO
    
    var body: some View {
        HStack(spacing: 16) {
            Group {
                if let image = vo.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(decorative: "")
                        .resizable()
                }
            }
            .frame(width: 70, height: 100, alignment: .center)
            .background(Color.gray)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(vo.title)
                    .font(.title2)
                    .lineLimit(2)
                
                if let releaseYear = vo.releaseYear {
                    Text(releaseYear)
                        .font(.callout)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }
                
                if let overview = vo.overview {
                    Text(overview)
                        .font(.body)
                        .lineLimit(2)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .onAppear(perform: {
            vo.downloadImage()
        })
    }
}

struct MovieCellUI_Previews: PreviewProvider {
    static var previews: some View {
        let dto = MovieDTO(id: 1, title: "El Club de la Lucha", overview: "This is an overview muy muy largo y tal y cual asdf adsf asdf as df asdf asdf asd f", poster: "https://picsum.photos/id/43/3000", releaseDate: "2020-01-01", genres: nil)
        let movie = Movie(from: dto)
        let vo = MovieCellVO(from: movie)
        
        MovieCellUI(vo: vo)
    }
}
