//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Devere Weaver on 12/27/23.
//

import UIKit

class FoodTableViewController: UITableViewController {
    /* The FoodTableViewController will be both the data source and the delegate for the
     * table view to update its appearance.
     */
    
    // MARK: - Properties
    var meals: [Meal] {
        // computed property for three meals containing foods
        let breakfast = Meal(name: "breakfast", 
                             food: [Food(name: "eggs", description: "some eggs"),
                                    Food(name: "bacon", description: "some bacon"),
                                    Food(name: "rice", description: "some jasmine rice")
                            ])
        let lunch = Meal(name: "lunch", 
                         food: [Food(name: "chicken breast", description: "dry AF"),
                                Food(name: "rice", description: "more jasmine rice"),
                                Food(name: "bean", description: "black beans")
                         ])
        let dinner = Meal(name: "dinner", 
                          food: [Food(name: "steak", description: "a ribeye steak"),
                                 Food(name: "potatoes", description: "roasted potatoes"),
                                 Food(name: "broccoli", description: "sauted broccoli")
                          ])
        let meals: [Meal] = [breakfast, lunch, dinner]
        return meals
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        /* Return the total number of meals to be individual sections */
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /* Return the number of Food objects in each Meal section*/
        let numberOfRows = meals[section].food.count
        return numberOfRows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* update each cell to properly display the model object data */
        // dequeue a Food cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)

        // access the Meal section
        let meal = meals[indexPath.section]
        
        // access the Food array for each Meal section
        let food = meal.food[indexPath.row]
        
        // update each cell to contain the name of the food and the description
        var content = cell.defaultContentConfiguration()
        content.text = food.name
        content.secondaryText = food.description
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        /* display the name of each section in the table */
        return meals[section].name
    }

}
