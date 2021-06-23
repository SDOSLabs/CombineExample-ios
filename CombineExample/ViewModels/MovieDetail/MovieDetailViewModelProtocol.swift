//
//  MovieDetailViewModelProtocol.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation
import Combine

enum MovieDetailState {
    case initial
    case loading
    case success(MovieDetailVO)
    case failure(UseCaseError)
}

struct MovieDetailViewModelInput {
    let appear: AnyPublisher<Void, Never>
}

struct MovieDetailViewModelOutput {
    let state: AnyPublisher<MovieDetailState, Never>
}

protocol MovieDetailViewModelProtocol {
    func bind(input: MovieDetailViewModelInput) -> MovieDetailViewModelOutput
}
