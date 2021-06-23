//
//  ScreenBuilder.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 15/6/21.
//

import Foundation
import UIKit

final class ScreenBuilder {
    
    static func build(screen: Screen) -> UIViewController {
        switch screen {
        case .movieList:
            let useCase = SearchMoviesUseCase()
            let viewModel = MovieListViewModel(searchMoviesUseCase: useCase)
            return MovieListViewController(viewModel: viewModel)
        case .movieDetail(let movie):
            let useCase = MovieDetailsUseCase()
            let viewModel = MovieDetailViewModel(id: movie.id, useCase: useCase)
            return MovieDetailViewController(viewModel: viewModel)
        }
    }
}
