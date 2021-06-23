//
//  UseCaseError.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 14/6/21.
//

import Foundation

enum UseCaseError: Error {
    case cancelled
    case invalidParameters(String)
    case networkError(error: NetworkError)
}
