//
//  Cocktail.swift
//  CocktailDemo
//
//  Created by Ravina on 31/01/20.
//  Copyright © 2020 Ravina. All rights reserved.
//

import Foundation
import UIKit

struct Cocktail {
    
    init(){}
    
    var id = ""
    var drink = ""
    var thumbnail = ""
    
    init(data: [String: Any]) {
        id = data["idDrink"] as? String ?? (data["idDrink"] as? NSNumber)?.stringValue ?? ""
        drink = data["strDrink"] as? String ?? (data["strDrink"] as? NSNumber)?.stringValue ?? ""
        thumbnail = data["strDrinkThumb"] as? String ?? (data["strDrinkThumb"] as? NSNumber)?.stringValue ?? ""
    }
    
    static func getArrayCocktail(arrData: [[String:Any]]) -> [Cocktail] {
        var arrCocktail = [Cocktail]()
        
        for drink in arrData {
            arrCocktail.append(Cocktail(data: drink))
        }
        
        return arrCocktail
    }
    
}
