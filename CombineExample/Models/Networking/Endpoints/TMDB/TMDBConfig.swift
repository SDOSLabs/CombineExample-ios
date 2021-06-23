//
//  TMDBConfig.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

struct TMDBConfig {
    static let baseUrl = URL(string: "https://api.themoviedb.org/3/")!
    static let apiKey = "13df8e53c315a538297e46975e3c5ea8"
    
    static let originalPosterBaseUrl = URL(string: "https://image.tmdb.org/t/p/original/")!
    static let smallPosterBaseUrl = URL(string: "https://image.tmdb.org/t/p/w154/")!
    
    struct EndpointPath {
        static let searchMovie = "search/movie"
        static let movieDetails = "movie"
    }
    
    enum Key: String {
        case apiKey = "api_key"
        case query
        case language
    }
    
    struct DateFormat {
        static let movieReleaseDate = "yyyy-MM-dd"
    }
}
