//
//  MovieImageDownloadUseCaseProtocol.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation
import Combine

protocol MovieImageDownloadUseCaseProtocol {
    func downloadImage(for movie: Movie, size: PosterSize) -> AnyPublisher<Data?, URLError>
}
