//
//  MovieCell.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 8/6/21.
//

import Foundation
import UIKit
import Combine

class MovieCell: UITableViewCell {
    private var subscriptions = [AnyCancellable]()
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clean()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions.removeAll()
        clean()
    }
    
    func populate(with viewModel: MovieCellViewModelProtocol) {
        let output = viewModel.bind()
        
        output.movie.map { $0.title }
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
        
        output.movie.map { $0.releaseYear }
            .assign(to: \.text, on: yearLabel)
            .store(in: &subscriptions)
        
        output.movie.map { $0.overview }
            .assign(to: \.text, on: overviewLabel)
            .store(in: &subscriptions)
        
        output.movie.flatMap { $0.image }
            .assign(to: \.image, on: posterImageView)
            .store(in: &subscriptions)
    }
    
    private func clean() {
        titleLabel.text = ""
        yearLabel.text = ""
        overviewLabel.text = ""
        posterImageView.image = nil
    }
}
