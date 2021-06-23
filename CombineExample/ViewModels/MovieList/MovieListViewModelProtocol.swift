//
//  MovieListViewModelProtocol.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import Combine
import UIKit

enum MovieListState {
    case initial
    case loading
    case success([MovieCellViewModel])
    case noResults
    case failure(UseCaseError)
}

struct MovieListViewModelInput {
    let search: AnyPublisher<String, Never>
    let cancelSearch: AnyPublisher<Void, Never>
    let selection: AnyPublisher<Int, Never>
}

struct MovieListViewModelOutput {
    let state: AnyPublisher<MovieListState, Never>
    let showDetail: AnyPublisher<UIViewController, Never>
}

protocol MovieListViewModelProtocol {
    func bind(input: MovieListViewModelInput) -> MovieListViewModelOutput
}
