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
    private var lastContentOffset: CGFloat = 0 // we set a variable to hold the contentOffSet before scroll view scrolls
    private var arrdrinks = [Cocktail]()
    
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
    
    // this delegate is called when the scrollView (i.e your UITableView) will start scrolling
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            // did move up
            view.endEditing(true)
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            // did move down
            view.endEditing(true)
        } else {
            // didn't move
        }
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
        return arrdrinks.count
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
        let currentObj = arrdrinks[indexPath.row]
        cell.contentView.alpha = 0
        cell.configureDataWithCell(currentObj)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentObj = arrdrinks[indexPath.row]
        let navVc = CocktailDetailViewController.instantiate(fromAppStoryboard: .Main)
        navVc.selectedDrink = currentObj
        navigationController?.pushViewController(navVc, animated: true)
    }
}

// MARK:- API Call
extension ViewController {
    private func fetchCocktails() {
        let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(txtIngredients.text!)")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            self.arrdrinks.removeAll()
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                let posts = json?["drinks"] as? [[String: Any]] ?? [[String: Any]]()
                DispatchQueue.main.async {
                    self.arrdrinks = Cocktail.getArrayCocktail(arrData: posts)
                    self.tblCocktailList.reloadData()
                }
                
            } catch _ {
                DispatchQueue.main.async {
                    self.tblCocktailList.reloadData()
                    let alert = UIAlertController(title: "Error", message: "Enter ingredient name", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }).resume()
    }
}



