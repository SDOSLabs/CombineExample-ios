//
//  MovieCellVO.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit
import Combine

struct MovieCellVO: VO {
    let title: String
    let releaseYear: String?
    let overview: String?
    let image: AnyPublisher<UIImage?, Never>
    
    init(from domain: Movie) {
        title = domain.title
        releaseYear = domain.releaseDate.flatMap(Self.releaseDateFormatter.string)
        overview = domain.overview
        
        image = domain.downloadPoster(size: .small)
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
