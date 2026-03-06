//
//  Items.swift
//  login-uikit-ui-testing
//
//  Created by Jessica Vasquez on 11/02/2026.
//

import UIKit

struct Item {
    let title: String
    let image: UIImage
    
    /*
     struct Movie {
     let title: String
     let imageURL: URL
     }
     */
    
    // TODO: - image must be a url
}

struct MovieViewModel {
    let title: String
    let imageURL: URL
    let placeholderImage: UIImage = UIImage(named: "movie_poster") ?? UIImage()
}

typealias Items = [Item] // ****** check later
