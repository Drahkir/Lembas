//
//  ViewController.swift
//  Lembas
//
//  Created by Rikhard Mikac on 9/26/15.
//  Copyright © 2015 Sleepy Puppy LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet var oldYieldTextField : UITextField!
    @IBOutlet var newYieldTextField : UITextField!
    
    var arrayOfIngredients: [Ingredient] = [Ingredient]()
    
    override func viewDidLoad() {
        ingredientsTable.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
        super.viewDidLoad()
        self.setupIngredient()
        refreshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        resignFirstResponder()
    }

    func setupIngredient() {
        let ingredient1 = Ingredient(name: "", oldQty: 0)
       
        arrayOfIngredients.append(ingredient1)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrayOfIngredients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: LembasTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! LembasTableViewCell
        
        let ingredient = arrayOfIngredients[indexPath.row]
        cell.setCell(ingredient.name, oldQty: Int(ingredient.oldQty))
        if(ingredient.newQty > 0) {
            cell.newQtyLabel.text = String(format: "%0.2f", ingredient.newQty)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete && indexPath.row != 0 {
            arrayOfIngredients.removeAtIndex(indexPath.row)
            self.ingredientsTable.reloadData()
        }
    }
    let calcNewQty = BakingCalculatorModel(oldQty: 0, oldYield: 0, newYield: 0)
    
    func refreshUI() {
        for ingredient in arrayOfIngredients {
            ingredient.newQty = ingredient.bakingCalculatorModel.newQty
        }
        self.ingredientsTable.reloadData()
    }
    
    @IBAction func calculateTapped(sender : AnyObject) {
        for ingredient in arrayOfIngredients {
            ingredient.bakingCalculatorModel.oldQty = ingredient.oldQty
            ingredient.bakingCalculatorModel.oldYield = Double((oldYieldTextField.text! as NSString).doubleValue)
            ingredient.bakingCalculatorModel.newYield = Double((newYieldTextField.text! as NSString).doubleValue)
        }
        refreshUI()
    }
    
    @IBAction func createNewIngredientRow(sender : AnyObject) {
        let textField = sender as! UITextField
        let view = textField.superview!
        let cell = view.superview as! LembasTableViewCell
        let indexPath = ingredientsTable.indexPathForCell(cell)
        
        if(indexPath!.row == arrayOfIngredients.count - 1) {
            let newIngredient = Ingredient(name: "", oldQty: 0)
            arrayOfIngredients.append(newIngredient)
            let nextIndexPath=NSIndexPath(forRow: indexPath!.row + 1, inSection: indexPath!.section);
            self.ingredientsTable.insertRowsAtIndexPaths([nextIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    @IBAction func saveNameToArray(sender : AnyObject) {
        
        let textField = sender as! UITextField
        let view = textField.superview!
        let cell = view.superview as! LembasTableViewCell
        let indexPath = ingredientsTable.indexPathForCell(cell)
        
        arrayOfIngredients[indexPath!.row].name = textField.text!
    }
    
    @IBAction func saveQtyToArray(sender : AnyObject) {
        let textField = sender as! UITextField
        let view = textField.superview!
        let cell = view.superview as! LembasTableViewCell
        let indexPath = ingredientsTable.indexPathForCell(cell)
        let textVal = Double(textField.text!)
        
        if(textVal != nil) {
            arrayOfIngredients[indexPath!.row].oldQty = textVal!
        }
    }
}

