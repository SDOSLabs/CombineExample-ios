//
//  MovieDetailsUseCaseProtocol.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation
import Combine

protocol MovieDetailsUseCaseProtocol {
    func movieDetails(for id: Int) -> AnyPublisher<Movie, UseCaseError>
}
