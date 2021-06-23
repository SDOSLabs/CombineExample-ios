//
//  VO+Movie.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 15/6/21.
//

import Foundation

extension VO where T == Movie {
    static var releaseDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        return formatter
    }
}
