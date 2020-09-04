//
//  EndPointConnect.swift
//  customer
//
//  Created by Estudiantes on 9/4/20.
//  Copyright © 2020 Estudiantes. All rights reserved.
//

import UIKit

enum httpCode: CustomStringConvertible{
    case get
    case put
    case delete
    case post
    var description: String{
        switch self{
        case .get:
            return "GET"
        case .delete:
            return "DELETE"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        default:
            return "GET"
        }
    }
}

typealias  Result = ([[String:Any]]?)->Void

class EndPointConnect: NSObject {
    
    var session:URLSession?
    var request:URLRequest?
    var apiHost:String
    
    init(host:String){
        self.apiHost = host
        session = URLSession.shared
    }
    

    func executeQuery(httpPath:String, httpMethod:httpCode, completion:@escaping Result, httpRequestParam:[String:String]? = nil ){
        request = URLRequest(url:URL(string: apiHost+httpPath)!)
        request?.httpMethod = httpMethod.description
        
        if let params = httpRequestParam{
            for param in params {
                request?.setValue(param.value,forHTTPHeaderField: param.key)
            }
        }
        
        session?.dataTask(with:request!){(data, response, error) in
            do {
                let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String:Any]]
                
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch let error{
                print(error.localizedDescription)
            }
        }.resume()
            }
}
