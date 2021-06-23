//
//  MovieCellViewModel.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit
import Combine

final class MovieCellViewModel {
    private let movie: Movie
    private lazy var movieVO: MovieCellVO = {
        return MovieCellVO(from: movie)
    }()
    
    init(movie: Movie) {
        self.movie = movie
    }
}

extension MovieCellViewModel: MovieCellViewModelProtocol {
    
    func bind() -> MovieCellViewModelOutput {        
        let vo = Just<MovieCellVO>(movieVO)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return MovieCellViewModelOutput(movie: vo)
    }
}
