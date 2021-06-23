//
//  NetworkService.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation
import Combine

final class NetworkService {
    private let baseUrl: URL
    private let session: URLSession
    
    init(baseUrl: URL, session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.baseUrl = baseUrl
        self.session = session
    }
    
    func request<T: Endpoint>(_ endpoint: T) -> AnyPublisher<T.Resource, NetworkError> {
        guard let request = endpoint.request(baseUrl: baseUrl) else {
            return Fail(error: .invalidRequest)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .mapError { .requestError(urlError: $0) }
            .flatMap { result -> AnyPublisher<T.Resource, NetworkError> in
                guard let response = result.response as? HTTPURLResponse else {
                    return Fail(error: .invalidResponse)
                        .eraseToAnyPublisher()
                }

                guard 200..<300 ~= response.statusCode else {
                    return Fail(error: .statusCodeError(statusCode: response.statusCode,
                                                                    data: result.data))
                        .eraseToAnyPublisher()
                }
                
                return Just(result.data)
                    .decode(type: T.Resource.self, decoder: JSONDecoder())
                    .mapError {
                        .decodeError(error: $0)
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
