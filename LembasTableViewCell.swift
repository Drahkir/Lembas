//
//  LembasTableViewCell.swift
//  Lembas
//
//  Created by Rikhard Mikac on 1/13/16.
//  Copyright © 2016 Sleepy Puppy LLC. All rights reserved.
//

import UIKit

class LembasTableViewCell: UITableViewCell {
    @IBOutlet var ingredientTextField : UITextField!
    @IBOutlet var oldQtyTextField : UITextField!
    @IBOutlet var newQtyLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var ingredientsArray = [Ingredient]()
    
    func setCell(ingredientName: String, oldQty: Int) {
        self.ingredientTextField.text = ingredientName
        self.oldQtyTextField.text = String(oldQty)
    }
    
    @IBAction func viewTapped(sender : AnyObject) {
        resignFirstResponder()
    }
}
