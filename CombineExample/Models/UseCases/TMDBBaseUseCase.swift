//
//  BaseUseCase.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

class TMDBBaseUseCase {
    let networkService = NetworkService(baseUrl: TMDBConfig.baseUrl)
}
