//
//  Domain.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 7/6/21.
//

import Foundation

protocol Domain {
    associatedtype T: DTO
    
    init(from dto: T)
}
