//
//  Array+DomainMappable.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 7/6/21.
//

import Foundation

extension Array where Element: DomainMappable {
    func toDomain() -> [Element.DomainType] {
        map { $0.toDomain() }
    }
}
