//
//  Genre.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation

struct Genre: Domain {
    let id: Int
    let name: String
    
    init(from dto: GenreDTO) {
        id = dto.id
        name = dto.name
    }
}
