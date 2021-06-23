//
//  SearchMoviesUseCaseProtocol.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation
import Combine

protocol SearchMoviesUseCaseProtocol {
    func searchMovies(by name: String) -> AnyPublisher<[Movie], UseCaseError>
}
