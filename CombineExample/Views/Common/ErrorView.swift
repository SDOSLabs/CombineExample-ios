//
//  ErrorView.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 14/6/21.
//

import UIKit

final class ErrorView: UIView {

    @IBOutlet private weak var errorLabel: UILabel!
    
    func populate(_ error: Error) {
        errorLabel.text = error.localizedDescription
    }
}
