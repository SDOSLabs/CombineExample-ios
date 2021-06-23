//
//  MovieDetailVO.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 14/6/21.
//

import Foundation
import Combine
import UIKit

struct MovieDetailVO: VO {
    let title: String
    let releaseYear: String?
    let overview: String?
    let image: AnyPublisher<UIImage?, Never>
    let genres: String?
    
    init(from domain: Movie) {
        title = domain.title
        releaseYear = domain.releaseDate.flatMap(Self.releaseDateFormatter.string)
        overview = domain.overview
        genres = domain.genres?.map { $0.name }.joined(separator: ", ")
        
        image = domain.downloadPoster(size: .original)
            .compactMap { data -> UIImage? in
                guard let data = data else { return nil }
                return UIImage(data: data)
            }
            .replaceError(with: nil)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
