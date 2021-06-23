//
//  BaseViewController.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 14/6/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    private var loadingView: LoadingView!
    private var errorView: ErrorView!
    private var infoView: InfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLoadingView()
        configErrorView()
        configInfoView()
    }
}

// MARK: - Loader funcs

extension BaseViewController {
    
    private func configLoadingView() {
        loadingView = LoadingView.fromNib()
        view.addSubview(loadingView)
        
        [
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        .forEach { $0.isActive = true }
        
        hideLoader()
    }
    
    func showLoader() {
        loadingView.startAnimating()
        loadingView.isHidden = false
    }
    
    func hideLoader() {
        loadingView.isHidden = true
        loadingView.stopAnimating()
    }
}

// MARK: - Error view funcs

extension BaseViewController {
    
    private func configErrorView() {
        errorView = ErrorView.fromNib()
        view.addSubview(errorView)
        
        [
            errorView.topAnchor.constraint(equalTo: view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            errorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        .forEach { $0.isActive = true }
        
        hideErrorView()
    }
    
    func showErrorView(_ error: Error) {
        errorView.populate(error)
        errorView.isHidden = false
    }
    
    func hideErrorView() {
        errorView.isHidden = true
    }
}

// MARK: - InfoView funcs

extension BaseViewController {
    
    private func configInfoView() {
        infoView = InfoView.fromNib()
        view.addSubview(infoView)
        
        [
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            infoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]
        .forEach { $0.isActive = true }
        
        hideInfoView()
    }
    
    func showInfoView(title: String, image: UIImage?) {
        infoView.populate(title: title, image: image)
        infoView.isHidden = false
    }
    
    func hideInfoView() {
        infoView.isHidden = true
    }
}
