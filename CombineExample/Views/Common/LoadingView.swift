//
//  LoadingView.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 14/6/21.
//

import UIKit

final class LoadingView: UIView {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
