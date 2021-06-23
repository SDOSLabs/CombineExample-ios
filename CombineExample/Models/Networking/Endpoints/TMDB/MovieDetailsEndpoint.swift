//
//  MovieDetailsEndpoint.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

struct MovieDetailsEndpoint: Endpoint {
    let id: Int
    
    var path: String {
        TMDBConfig.EndpointPath.movieDetails + "/\(id)"
    }
    
    var method: HttpMethod {
        .get
    }
    
    var urlParameters: [String : CustomStringConvertible] {
        [
            TMDBConfig.Key.apiKey.rawValue: TMDBConfig.apiKey,
            TMDBConfig.Key.language.rawValue: Locale.preferredLanguages[0]
        ]
    }
    
    var bodyParameters: [String : Any] {
        [:]
    }
    
    var decodable: MovieDTO.Type {
        MovieDTO.self
    }
}
