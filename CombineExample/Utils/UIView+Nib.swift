//
//  UIView+Nib.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 14/6/21.
//

import Foundation
import UIKit

extension UIView {
    static func fromNib<T: UIView>() -> T? {
        guard let nib = Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil),
              let view = nib[0] as? T else { return nil }
        
        return view
    }
}
