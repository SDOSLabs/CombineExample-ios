//
//  UISearchBar+Publisher.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit
import Combine

extension UISearchTextField {
    func textPublisher() -> AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification)
            .compactMap { ($0.object as? UISearchTextField)?.text }
            .eraseToAnyPublisher()
    }
}
