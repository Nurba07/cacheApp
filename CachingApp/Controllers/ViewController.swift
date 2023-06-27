//
//  ViewController.swift
//  CachingApp
//
//  Created by Nurbakhyt on 26.06.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var unsplashURL: String = "https://api.unsplash.com/photos/?client_id=eFdUJ2rNaLBu8Pxy5cvtZOetmcql7Ypf24TWofcXYzQ"
    var photos: [Unsplash] = [Unsplash](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Request.shared.getPhotos(url: unsplashURL) { splash in
            self.photos = splash
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.nib, forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    func getPhotos(url: String) {
        guard let url = URL(string: url) else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let images = try? JSONDecoder().decode([Unsplash].self, from: data){
                    self.photos = images
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
        cell.textLabel?.text = photos[indexPath.row].id
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? SecondViewController {
            vc.detailedImade = photos[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}
