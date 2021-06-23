//
//  NetworkError.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case invalidResponse
    case requestError(urlError: URLError)
    case statusCodeError(statusCode: Int, data: Data)
    case decodeError(error: Error)
}
