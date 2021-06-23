//
//  UITableViewCell+Identifier.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
