//
//  Endpoint.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

protocol Endpoint {
    associatedtype Resource: Decodable
    
    var path: String { get }
    var method: HttpMethod { get }
    var urlParameters: [String: CustomStringConvertible] { get }
    var bodyParameters: [String: Any] { get }
    var decodable: Resource.Type { get }
}

extension Endpoint {
    func request(baseUrl: URL) -> URLRequest? {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = urlParameters.keys.map { URLQueryItem(name: $0, value: urlParameters[$0]?.description) }
        guard let url = components.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if bodyParameters.count > 0 {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParameters)
        }
        
        return request
    }
}
