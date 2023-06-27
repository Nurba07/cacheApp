//
//  Request.swift
//  CachingApp
//
//  Created by Nurbakhyt on 27.06.2023.
//

import UIKit

class Request {
    static var shared = Request()
    
     func getPhotos(url: String, completionHandler: @escaping(_ splash: [Unsplash]) -> ()) {
         guard let url = URL(string: url) else {return}

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let images = try? JSONDecoder().decode([Unsplash].self, from: data){
                     completionHandler(images)
                }else{
                    print("Check Unsplash Model")
                }
            }else {
                print(error?.localizedDescription as Any)
            }
        }
        dataTask.resume()
    }
}
