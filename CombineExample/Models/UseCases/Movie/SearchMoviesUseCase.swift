//
//  SearchMoviesUseCase.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation
import Combine

final class SearchMoviesUseCase: TMDBBaseUseCase, SearchMoviesUseCaseProtocol {
    
    func searchMovies(by name: String) -> AnyPublisher<[Movie], UseCaseError> {
        Deferred { [weak self] () -> AnyPublisher<[Movie], UseCaseError> in
            guard let self = self else {
                return Fail(error: .cancelled)
                    .eraseToAnyPublisher()
            }
            
            if name.isEmpty {
                return Fail(error: .invalidParameters("Search input should not be empty"))
                    .eraseToAnyPublisher()
            }
            
            return self.networkService
                .request(SearchMoviesEndpoint(query: name))
                .mapError { .networkError(error: $0) }
                .receive(on: DispatchQueue.global())
                .map { $0.results }
                .map { $0.toDomain() }
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
