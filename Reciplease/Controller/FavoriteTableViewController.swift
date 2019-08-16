//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

final class FavoriteTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var recipeList = FavoriteRecipe.fetchAll()
    private let imageCache = NSCache<NSString, UIImage>()
    var favoriteRecipe: FavoriteRecipe?

    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.tableFooterView = UIView()
        super.viewWillAppear(animated)
        self.registerTableViewCells()
        updateData()
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Class Methods
    
    private func updateData(){
        recipeList = FavoriteRecipe.fetchAll()
        tableView.reloadData()
    }
    
    // MARK: - TableView Configuration
    
    private func registerTableViewCells(){
        let recipeCell = UINib(nibName: "CustomCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "CustomCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.favoriteRecipe = recipeList[indexPath.row]
        performSegue(withIdentifier: "segueToFavoriteDetail", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {return UITableViewCell()}
        let favoriteRecipe = recipeList[indexPath.row]
        cell.favoriteRecipe = favoriteRecipe
        
        guard let id = favoriteRecipe.id else{return cell}
        if let cachedImage = imageCache.object(forKey: NSString(string: id)) {
            cell.cellImageView.image = cachedImage
        }else{
            guard let imageData = favoriteRecipe.image else {return cell}
            guard let image = UIImage.init(data: imageData) else {return cell}
            
            self.imageCache.setObject(image, forKey: NSString(string: id))
            cell.cellImageView.image = image
        }
        cell.cellImageView.contentMode = .scaleAspectFill
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Add recipes in the list"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return recipeList.isEmpty ? 200 : 0
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToFavoriteDetail" {
            guard let detailVC = segue.destination as? FavoriteDetailViewController else {return}
            detailVC.favoriteRecipe = self.favoriteRecipe
        }
    }
}

