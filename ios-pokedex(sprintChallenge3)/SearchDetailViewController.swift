//
//  SearchDetailViewController.swift
//  ios-pokedex(sprintChallenge3)
//
//  Created by Dongwoo Pae on 6/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var infoStackView: UIStackView!
    
    var searchResultController: SearchResultController?
    var searchResult: SearchResult?

    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        if let searchResult = searchResult {
            uiAppear()
            updateViews(with: searchResult)
            navigationItem.title = searchResult.name
            self.searchResultController?.fetchImage(at: searchResult.sprite, completion: { (result) in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            })
        } else {
            uiDisappear()
            navigationItem.title = "Pokemon Search"
        }

    }

    
//this is set up this way is because sprite needs to show based on url of the pokemon
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = self.searchBar.text,
        let searchResultControllerPassed = searchResultController else {return}
            searchResultControllerPassed.perfomSearch(for: searchTerm) { (result) in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    self.uiAppear()
                    self.updateViews(with: pokemon)
                }
                self.searchResultController?.fetchImage(at: pokemon.sprite, completion: { (result) in
                    if let image = try? result.get(){
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                })
            }
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //???  appennd searchresult to own array. if searchResult == nil {
            
            self.navigationController?.popViewController(animated: true)
        //}
    }
    
    func updateViews(with pokemon: SearchResult) {
            navigationItem.title = pokemon.name
            self.nameLabel.text = pokemon.name
            self.idLabel.text = String(pokemon.id)
           //?? self.abilityLabel.text = searchResult.abilities
           //?? self.typeLabel.text = searchResult.types
    }
    
    func uiAppear() {
        self.infoStackView.isHidden = false
        self.saveButton.isHidden = false
    }
    
    func uiDisappear() {
        self.nameLabel.text = ""
        self.infoStackView.isHidden = true
        self.saveButton.isHidden = true
    }
}
