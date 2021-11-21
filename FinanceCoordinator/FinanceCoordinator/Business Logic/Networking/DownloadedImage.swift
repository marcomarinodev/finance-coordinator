//
//  ImageDownloader.swift
//  NewsApp
//
//  Created by Marinò, Marco on 14/11/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class DownloadedImage: UIImageView {
    
    var imageURL: URL?
    
    let activityIndicator = UIActivityIndicatorView()
    
    func loadImage(with url: URL) {
        
        activityIndicator.color = .darkGray
        
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        imageURL = url
        
        image = nil
        activityIndicator.startAnimating()
        
        // check if image is already in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        // image is not available in cache
        URLRequestAPIClient.downloadFile(with: url) { data, response, error in
            
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                })
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                     
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                }
            
                self.activityIndicator.stopAnimating()
            })
        }
        
    }
    
}
