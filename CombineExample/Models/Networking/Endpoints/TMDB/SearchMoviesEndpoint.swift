//
//  MoviesEndpoint.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

struct SearchMoviesEndpoint: Endpoint {
    let query: String
    
    var path: String {
        TMDBConfig.EndpointPath.searchMovie
    }
    
    var method: HttpMethod {
        .get
    }
    
    var urlParameters: [String : CustomStringConvertible] {
        [
            TMDBConfig.Key.query.rawValue: query,
            TMDBConfig.Key.apiKey.rawValue: TMDBConfig.apiKey,
            TMDBConfig.Key.language.rawValue: Locale.preferredLanguages[0]
        ]
    }
    
    var bodyParameters: [String : Any] {
        [:]
    }
    
    var decodable: SearchMoviesDTO.Type {
        SearchMoviesDTO.self
    }
}
