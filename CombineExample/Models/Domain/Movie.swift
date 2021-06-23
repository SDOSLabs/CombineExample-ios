//
//  Movie.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation
import Combine

struct Movie: Domain {    
    let id: Int
    let title: String
    let overview: String?
    let releaseDate: Date?
    let poster: String?
    let genres: [Genre]?
    
    init(from dto: MovieDTO) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        self.releaseDate = dto.releaseDate.flatMap(Movie.releaseDateFormatter.date)
        self.poster = dto.poster
        self.genres = dto.genres?.toDomain()
    }
}

extension Movie {
    static let releaseDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = TMDBConfig.DateFormat.movieReleaseDate
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    func downloadPoster(size: PosterSize) -> AnyPublisher<Data?, URLError> {
        let useCase = MovieImageDownloadUseCase()
        return useCase.downloadImage(for: self, size: size)
    }
}
