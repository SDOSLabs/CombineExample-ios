//
//  MovieDetailUseCase.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation
import Combine

final class MovieDetailsUseCase: TMDBBaseUseCase, MovieDetailsUseCaseProtocol {
    
    func movieDetails(for id: Int) -> AnyPublisher<Movie, UseCaseError> {
        Deferred { [weak self] () -> AnyPublisher<Movie, UseCaseError> in
            guard let self = self else {
                return Fail(error: UseCaseError.cancelled)
                    .eraseToAnyPublisher()
            }
            
            return self.networkService
                .request(MovieDetailsEndpoint(id: id))
                .mapError { .networkError(error: $0) }
                .receive(on: DispatchQueue.global())
                .map { $0.toDomain() }
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
