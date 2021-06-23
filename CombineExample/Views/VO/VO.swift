//
//  VO.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation

protocol VO {
    associatedtype T: Domain
    
    init(from domain: T)
}
