//
//  MovieImageUseCase.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation
import Combine

final class MovieImageDownloadUseCase: MovieImageDownloadUseCaseProtocol {
    func downloadImage(for movie: Movie, size: PosterSize) -> AnyPublisher<Data?, URLError> {
        Deferred { () -> AnyPublisher<Data?, URLError> in
            guard let path = movie.poster else {
                return Fail(error: URLError(.cancelled))
                    .eraseToAnyPublisher()
            }
            
            return URLSession.shared
                .dataTaskPublisher(for: size.posterUrl(path: path))
                .map { $0.data }
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
