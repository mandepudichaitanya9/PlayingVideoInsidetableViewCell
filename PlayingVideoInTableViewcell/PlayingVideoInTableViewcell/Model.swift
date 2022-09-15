//
//  Model.swift
//  PlayingVideoInTableViewcell
//
//  Created by chaitanya on 15/09/22.
//

import UIKit


// MARK: - Welcome
struct JsonModel: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let name: String
    let videos: [Video]
}

// MARK: - Video
struct Video: Codable {
    let description: String
    let sources: String
    let subtitle: String
    let thumb: String
    let title: String

   
}


let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    
                }
            }

        }).resume()
    }
}



