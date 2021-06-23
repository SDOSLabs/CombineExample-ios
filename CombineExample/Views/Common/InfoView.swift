//
//  InfoView.swift
//  CombineExample
//
//  Created by Antonio Martínez Manzano on 15/6/21.
//

import UIKit

class InfoView: UIView {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    func populate(title: String, image: UIImage?) {
        infoLabel.text = title
        imageView.image = image
    }
}
