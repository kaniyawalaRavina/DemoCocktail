//
//  CocktailDataTableViewCell.swift
//  CocktailDemo
//
//  Created by Ravina on 31/01/20.
//  Copyright © 2020 Ravina. All rights reserved.
//

import UIKit
import SDWebImage

class CocktailDataTableViewCell: UITableViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var lblCocketailName: UILabel!
    @IBOutlet weak var imgCocktail: UIImageView!

    // MARK:- Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK:- Methods
    private func setupUI() {
        imgCocktail.layer.cornerRadius = 8
        imgCocktail.clipsToBounds = true
    }
    
    func configureDataWithCell(_ data: Cocktail) {
        lblCocketailName.text = data.drink
        imgCocktail.sd_setImage(with: URL(string: data.thumbnail), placeholderImage: nil, options: .retryFailed, completed: nil)
    }
}
