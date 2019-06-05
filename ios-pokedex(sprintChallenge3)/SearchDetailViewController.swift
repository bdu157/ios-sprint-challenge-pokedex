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
    var pokemons: Pokemon?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        if let pokemon = pokemons {
            uiAppear()
            updateViews(with: pokemon)
            self.searchResultController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (result) in
                if let image = try? result.get() {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            })
        } else {
            uiDisappear()
            DispatchQueue.main.async {
             self.navigationItem.title = "Pokemon Search"
            }
        }
    }

    
//this is set up this way is because sprite needs to show based on url of the pokemon
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = self.searchBar.text,
        let searchResultControllerPassed = searchResultController else {return}
            searchResultControllerPassed.perfomSearch(for: searchTerm) { (pokemon, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.uiAppear()
                    self.updateViews(with: pokemon)
                 //   self.pokemons = pokemon
                }
                self.searchResultController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (result) in
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
    
    func updateViews(with pokemon: Pokemon) {
            navigationItem.title = pokemon.name.capitalized
            self.nameLabel.text = pokemon.name.capitalized
            self.idLabel.text = String(pokemon.id)
            self.abilityLabel.text = pokemon.abilities[0].ability.name
            self.typeLabel.text = pokemon.types[0].type.name
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
