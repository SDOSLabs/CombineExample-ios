//
//  MovieDetailViewController.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 9/6/21.
//

import Foundation
import UIKit
import Combine

final class MovieDetailViewController: BaseViewController {
    private let viewModel: MovieDetailViewModel
    private let appearSubject = PassthroughSubject<Void, Never>()
    private var subscriptions = [AnyCancellable]()
    
    private var state: MovieDetailState? {
        didSet {
            guard let state = state else { return }
            
            switch state {
            case .initial, .loading:
                showLoader()
            case .success(let movie):
                populate(movie)
                hideLoader()
            case .failure(let error):
                hideLoader()
                showErrorView(error)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        let appear = appearSubject.eraseToAnyPublisher()
        let input = MovieDetailViewModelInput(appear: appear)
        
        let output = viewModel.bind(input: input)
        
        output.state
            .sink { [weak self] state in
                self?.state = state
            }.store(in: &subscriptions)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appearSubject.send()
    }
    
    private func populate(_ movie: MovieDetailVO) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseYear
        genresLabel.text = movie.genres
        overviewLabel.text = movie.overview
        
        [titleLabel, yearLabel, genresLabel, overviewLabel].forEach {
            $0.isHidden = $0.text?.isEmpty ?? true
        }
        
        movie.image
            .assign(to: \.image, on: imageView)
            .store(in: &subscriptions)
    }
}
