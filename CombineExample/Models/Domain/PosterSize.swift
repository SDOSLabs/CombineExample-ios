//
//  PosterSize.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation

enum PosterSize {
    case original
    case small
    
    func posterUrl(path: String) -> URL {
        switch self {
        case .original:
            return TMDBConfig.originalPosterBaseUrl.appendingPathComponent(path)
        case .small:
            return TMDBConfig.smallPosterBaseUrl.appendingPathComponent(path)
        }
    }
}
