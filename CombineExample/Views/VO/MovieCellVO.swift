//
//  MovieCellVO.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit
import Combine

final class MovieCellVO: VO, Identifiable, ObservableObject {
    private let domain: Movie
    
    let id = UUID()
    let title: String
    let releaseYear: String?
    let overview: String?
    @Published var image: UIImage?
    
    required init(from domain: Movie) {
        self.domain = domain
        title = domain.title
        releaseYear = domain.releaseDate.flatMap(Self.releaseDateFormatter.string)
        overview = domain.overview
    }
    
    func downloadImage() {
        domain.downloadPoster(size: .small)
            .compactMap { data -> UIImage? in
                guard let data = data else { return nil }
                return UIImage(data: data)
            }
            .replaceError(with: nil)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .assign(to: &$image)
    }
}
