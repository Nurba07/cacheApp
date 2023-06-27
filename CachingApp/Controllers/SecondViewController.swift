//
//  SecondViewController.swift
//  CachingApp
//
//  Created by Nurbakhyt on 27.06.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
        
    var detailedImade: Unsplash? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = detailedImade?.urls.raw else { return }
        ImageLoader.image(for: url) { image in
            self.imageView.image = image
        }
        idLabel.text = detailedImade?.id ?? "Error"
        // Do any additional setup after loading the view.
    }
}
