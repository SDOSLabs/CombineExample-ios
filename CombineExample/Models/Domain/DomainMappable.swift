//
//  DomainMappable.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 27/5/21.
//

import Foundation

protocol DomainMappable {
    associatedtype DomainType: Domain
    
    func toDomain() -> DomainType
}
