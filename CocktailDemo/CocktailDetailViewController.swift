//
//  CocktailDetailViewController.swift
//  CocktailDemo
//
//  Created by Ravina on 31/01/20.
//  Copyright © 2020 Ravina. All rights reserved.
//

import UIKit

class CocktailDetailViewController: UIViewController {
    
    // MARK:- IBOutlets
      @IBOutlet weak var lblCocketailName: UILabel!
      @IBOutlet weak var imgCocktail: UIImageView!
      
      // MARK:- Variable
      var selectedDrink : Cocktail!
      
      // MARK:- LifeCycle
      override func viewDidLoad() {
          super.viewDidLoad()

          // Do any additional setup after loading the view.
          setupUI()
      }
      
      // MARK:- Methods
      private func setupUI() {
          
          title = selectedDrink.drink
          
          imgCocktail.layer.cornerRadius = 10
          imgCocktail.clipsToBounds = true
          
          setData()
      }

      private func setData() {
          lblCocketailName.text = selectedDrink.drink
          imgCocktail.sd_setImage(with: URL(string: selectedDrink.thumbnail), placeholderImage: nil, options: .retryFailed, completed: nil)
      }
}
