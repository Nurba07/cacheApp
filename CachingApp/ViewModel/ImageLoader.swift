//
//  ImageLoader.swift
//  CachingApp
//
//  Created by Nurbakhyt on 27.06.2023.
//

import UIKit

class ImageLoader {

  private static let cache = NSCache<NSString, NSData>()

    class func image(for url: String, completionHandler: @escaping(_ image: UIImage?) -> ()) {
        
        guard let url = URL(string: url) else {return}
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            
            if let data = self.cache.object(forKey: url.absoluteString as NSString) {
                DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
                return
            }
            
            guard let data = NSData(contentsOf: url) else {
                DispatchQueue.main.async { completionHandler(nil) }
                return
            }
            
            self.cache.setObject(data, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async { completionHandler(UIImage(data: data as Data)) }
        }
    }

}
