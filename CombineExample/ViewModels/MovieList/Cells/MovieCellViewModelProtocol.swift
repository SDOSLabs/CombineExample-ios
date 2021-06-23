//
//  MovieCellViewModelProtocol.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit
import Combine

struct MovieCellViewModelOutput {
    let movie: AnyPublisher<MovieCellVO, Never>
}

protocol MovieCellViewModelProtocol {
    func bind() -> MovieCellViewModelOutput
}
