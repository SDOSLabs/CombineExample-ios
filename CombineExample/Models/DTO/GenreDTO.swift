//
//  GenreDTO.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation

struct GenreDTO: DTO {
    let id: Int
    let name: String
}

extension GenreDTO: DomainMappable {
    func toDomain() -> Genre {
        Genre(from: self)
    }
}
