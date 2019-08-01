//
//  ResultViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    let imageCache = NSCache<NSString, UIImage>()


    
    var recipesList = [Hit]()
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }
    
    func registerTableViewCells(){
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
        if segue.identifier == "segueToDetail"
        {
            guard let detailVC = segue.destination as? DetailViewController else {return}
            detailVC.recipe = self.recipe

        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {return UITableViewCell()}
        let recipe = recipesList[indexPath.row].recipe
        cell.recipe = recipe
        
        if let cachedImage = imageCache.object(forKey: NSString(string: recipe.image)) {
            cell.cellImageView.image = cachedImage
        }else{
            guard let imageData = recipe.image.data else {return cell}

            guard let image = UIImage(data: imageData) else{return cell}
            self.imageCache.setObject(image, forKey: NSString(string: recipe.image))

            cell.cellImageView.image = image
        }
        cell.cellImageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
}

extension String{
    var data: Data? {
        guard let url = URL(string: self) else{return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
