//
//  ResultViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    var recipesImages = [UIImage]()

    
    @IBOutlet var resultTableView: UITableView!
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
//            detailVC.view = self.view

        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {return UITableViewCell()}
        let recipe = recipesList[indexPath.row].recipe
        cell.recipe = recipe

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
