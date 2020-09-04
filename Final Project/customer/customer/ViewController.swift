//
//  ViewController.swift
//  contactos
//
//  Created by Estudiantes on 9/2/20.
//  Copyright © 2020 Estudiantes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var connection:EndPointConnect?
    
    
    @IBOutlet weak var tittle: UILabel!
    var request = URLRequest(url:URL(string: "http://34.72.128.224/customers")!)
    var session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connection = EndPointConnect(host: "http://34.72.128.224/")
        connection?.executeQuery(httpPath: "customers", httpMethod: .get, completion: {(persons) in
            let person = persons![3]
            DispatchQueue.main.async {
                self.tittle.text = person["name"]! as? String
            }
        })

        
    }

}



