//
//  ImageLoader.swift
//  Pokemons
//
//  Created by Дарья Балацун on 1.07.24.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

final class ImageLoader: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageFromURL(_ urlString: String?) {
        imageUrlString = urlString
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data) {
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    } else {
                        print(error?.localizedDescription ?? "Can't load image from URL")
                    }
                }
            }
        }.resume()
    }
}
    
