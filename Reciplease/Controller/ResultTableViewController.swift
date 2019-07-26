//
//  ResultViewController.swift
//  Reciplease
//
//  Created by Jordan MOREAU on 17/07/2019.
//  Copyright © 2019 Jordan MOREAU. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    @IBOutlet var resultTableView: UITableView!
    var recipesList = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableViewCells()
    }
    func registerTableViewCells(){
        let recipeCell = UINib(nibName: "CustomCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "CustomCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return self.recipesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as? CustomCell else {return UITableViewCell()}
        
//        let spending = spendings[indexPath.section][indexPath.row]
        cell.titleLabelView.text = recipesList[indexPath.row].recipe.label
        cell.servingsLabelView.text = String(Int(recipesList[indexPath.row].recipe.yield)) + " x ☺︎"
 
        guard let url = URL(string: recipesList[indexPath.row].recipe.image) else {return cell}
        cell.cellImageView.load(url: url)
        
        if recipesList[indexPath.row].recipe.totalTime != 0 {
            cell.timeLabelView.text = String(recipesList[indexPath.row].recipe.totalTime) + " min ⧖"
        }else{
            cell.timeLabelView.text = "-/- ⧖"
        }

        
        var healthLabelString = String()
        var i = 0
        
        for label in recipesList[indexPath.row].recipe.healthLabels{
            var stringHealth = String()

            
            switch label {
            case .alcoholCocktail: stringHealth = "Alcohol"
            case .alcoholFree: stringHealth = "Alcohol free"
            case .celeryFree: stringHealth = "Celery free"
            case .crustaceanFree: stringHealth = "Crustacean free"
            case .dairyFree: stringHealth = "Dairy free"
            case .eggFree: stringHealth = "Egg free"
            case .fishFree: stringHealth = "Fish free"
            case .glutenFree: stringHealth = "Gluten free"
            case .keto: stringHealth = "Keto friendly"
            case .kidneyFriendly: stringHealth = "Kidney friendly"
            case .kosher: stringHealth = "Kosher"
            case .lowPotassium: stringHealth = "Low potassium"
            case .lupineFree: stringHealth = "Lupine free"
            case .mustardFree: stringHealth = "Mustard free"
            case .noOilAdded: stringHealth = "No oil added"
            case .lowSugar: stringHealth = "Low sugar"
            case .paleo: stringHealth = "Paleo"
            case .peanutFree: stringHealth = "Peanut free"
            case .pescatarian: stringHealth = "Pescatarian"
            case .porkFree: stringHealth = "Pork free"
            case .redMeatFree: stringHealth = "Red meat free"
            case .sesameFree: stringHealth = "Sesame free"
            case .shellfishFree: stringHealth = "Shellfish free"
            case .soyFree: stringHealth = "Soy free"
            case .sugarConscious: stringHealth = "Sugar conscious"
            case .treeNutFree: stringHealth = "Tree nut tree"
            case .vegan: stringHealth = "Vegan"
            case .vegetarian: stringHealth = "Vegetarian"
            case .wheatFree: stringHealth = "Wheat free"
                
            }
            if i >= 1{
                healthLabelString += "\n"
            }
            healthLabelString += stringHealth + " ✔︎"
            
            i += 1
            
        }
        cell.healthLabelView.text = healthLabelString

        return cell
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
//   override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.text = "Add some tasks in the list"
//        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
//        label.textAlignment = .center
//        label.textColor = .darkGray
//        return label
//    }
//
//   override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return recipeList.isEmpty ? 200 : 0
//    }


}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.contentMode = .scaleAspectFill
                    }
                }
            }
        }
    }
}
