//
//  ViewController.swift
//  Super Market List
//
//  Created by Estudiantes on 7/18/20.
//  Copyright © 2020 David Cerdas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var shoppingList = [String]()
    
    @IBOutlet weak var amountOfProducts: UITextField!
    @IBOutlet weak var confirmationMessage: UILabel!
    @IBOutlet weak var textInputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Get the product from the textField
    @IBAction func addProductButton(_ sender: Any) {
        shoppingList.append(amountOfProducts.text!+" - "+textInputField.text!)
        textInputField.text=""
        amountOfProducts.text=""
        self.confirmationMessage.text = "Done ..."
        DispatchQueue.main.asyncAfter(deadline: .now()+2){
            self.confirmationMessage.text = ""
        }
        
        
    }


    @IBAction func showTheList(_ sender: Any) {
     performSegue(withIdentifier: "shoppingList", sender: self)
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShowShoppingList
        vc.shoppingListFinal = self.shoppingList
    }
}

