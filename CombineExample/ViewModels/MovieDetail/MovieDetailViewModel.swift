//
//  MovieDetailViewModel.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation
import Combine

final class MovieDetailViewModel {
    private let id: Int
    private let useCase: MovieDetailsUseCaseProtocol
    
    init(id: Int, useCase: MovieDetailsUseCaseProtocol) {
        self.id = id
        self.useCase = useCase
    }
}

extension MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    func bind(input: MovieDetailViewModelInput) -> MovieDetailViewModelOutput {
        
        let initial = Just<MovieDetailState>(.initial)
            .eraseToAnyPublisher()
        
        let loading: AnyPublisher<MovieDetailState, Never> = input.appear
            .map { .loading }
            .eraseToAnyPublisher()
        
        let movie: AnyPublisher<MovieDetailState, Never> = loading
            .flatMap { [weak self] _ -> AnyPublisher<Movie, UseCaseError> in
                guard let self = self else { return Fail(error: .cancelled).eraseToAnyPublisher() }
                return self.useCase.movieDetails(for: self.id)
            }
            .map { MovieDetailVO(from: $0) }
            .map { .success($0) }
            .catch { error -> AnyPublisher<MovieDetailState, Never> in
                Just(.failure(error))
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let state = Publishers.MergeMany(initial, loading, movie)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return MovieDetailViewModelOutput(state: state)
    }
}
