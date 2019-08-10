//
//  ResultViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

final class ResultTableViewController: UITableViewController {
    
    // MARK: Properties
    
    private let imageCache = NSCache<NSString, UIImage>()
    var recipesList = [Hit]()
    var recipe: Recipe?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }
    
    // MARK: - TableView
    
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: "CustomCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "CustomCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipesList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.recipe = recipesList[indexPath.row].recipe
        performSegue(withIdentifier: "segueToDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail"{
            guard let detailVC = segue.destination as? DetailViewController else {return}
            detailVC.recipe = self.recipe
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipesList[indexPath.row].recipe
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {return UITableViewCell()}
        cell.recipe = recipe
        
        // Image cache manager
        
        if let cachedImage = imageCache.object(forKey: NSString(string: recipe.image)) {
            cell.cellImageView.image = cachedImage
        }else{
            guard let imageData = recipe.image.data, let image = UIImage(data: imageData) else {return cell}
            self.imageCache.setObject(image, forKey: NSString(string: recipe.image))
            cell.cellImageView.image = image
        }
        cell.cellImageView.contentMode = .scaleAspectFill
        return cell
    }
}

