//
//  MovieDTO.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

struct MovieDTO: DTO {
    let id: Int
    let title: String
    let overview: String?
    let poster: String?
    let releaseDate: String?
    let genres: [GenreDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case poster = "poster_path"
        case releaseDate = "release_date"
        case genres
    }
}

extension MovieDTO: DomainMappable {
    func toDomain() -> Movie {
        Movie(from: self)
    }
}
