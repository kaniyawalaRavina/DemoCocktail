//
//  ViewController.swift
//  CocktailDemo
//
//  Created by Ravina on 31/01/20.
//  Copyright © 2020 Ravina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- IBOutlets
    @IBOutlet weak var txtIngredients: UITextField!
    @IBOutlet weak var btnFindCocktails: UIButton!
    @IBOutlet weak var tblCocktailList: UITableView!
    
    // MARK:- Variable
    
    
    // MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    // MARK:- Methods
    private func setupUI() {
        setupTable()
    }
    
    private func setupTable() {
        tblCocktailList.delegate = self
        tblCocktailList.dataSource = self
    }
    
    // MARK:- IBActions
    @IBAction func onBtnFindCocktails(_ sender: UIButton) {
        if !txtIngredients.text!.isEmpty {
            fetchCocktails()
        } else {
            let alert = UIAlertController(title: "Error", message: "Enter ingredient name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


// MARK:- UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }
        
        UIView.animate(withDuration: 0.8, animations: {
         cell.contentView.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CocktailDataTableViewCell", for: indexPath) as! CocktailDataTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK:- API Call
extension ViewController {
    private func fetchCocktails() {
        
    }
}


