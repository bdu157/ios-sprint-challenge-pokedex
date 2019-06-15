//
//  DetailViewController.swift
//  pokedex-practice
//
//  Created by Dongwoo Pae on 6/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UISearchBarDelegate {

    //properties
    var pokemon: Pokemon?
    var pokemonController: PokemonController?

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //UIappear/disappear outlets
    
    @IBOutlet weak var uiStack: UIStackView! // idLabel, typesLabel, abilitiesLabel, idinputLabel, typesinputLabel, abilitiesinputLabel
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    //outlets - GET through performSearch
    @IBOutlet weak var idinputLabel: UILabel!
    @IBOutlet weak var typesinputLabel: UILabel!
    @IBOutlet weak var abilitiesinputLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //if pokemon is nil
        //uidisappear else uiappear and fetchImage based on sprites(imageUrls) and updateViews
        if let pokemon = pokemon {
            self.updateViews(for: pokemon)
            self.searchBar.isHidden = true
        } else {
            self.uiDisappear()
            self.title = "Search Pokemon"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //performSearch
        //mainqueue => self.updateViews and self.pokemon = pokemon (data)
        guard let searchTerm = searchBar.text else {return}
        self.pokemonController?.performSearch(for: searchTerm, completion: { (pokemon, error) in
            if let error = error {
                print(error)
                return
            }
        
            guard let pokemon = pokemon else {
                print("there is no pokemon")
                return
            }
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.updateViews(for: pokemon)
            }

        })
    }
    
    //updateViews()
    func updateViews(for pokemon: Pokemon) {
        self.uiAppear()
        
        self.nameLabel.text = pokemon.name.capitalized
        self.idinputLabel.text = String(pokemon.id)
        self.typesinputLabel.text = pokemon.types[0].type.name
        self.abilitiesinputLabel.text = pokemon.abilities[1].ability.name
        
        self.title = pokemon.name.capitalized
        
        self.pokemonController?.fetchImage(at: pokemon.sprites.frontDefault, completion: { (result) in
            if let result = try? result.get() {
                DispatchQueue.main.async {
                    self.imageView.image = result
                }
            }
        })
    }
    
    //uiappear()
    func uiAppear() {
        uiStack.isHidden = false
        saveButton.isHidden = false
        nameLabel.isHidden = false
    }
    
    
    //uidisappear()
    func uiDisappear() {
        uiStack.isHidden = true
        saveButton.isHidden = true
        nameLabel.isHidden = true
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //self.pokemonController.createPokemon(for: pokemon)
        guard let pokemon = pokemon else {return}
        self.pokemonController?.createPokemon(for: pokemon)
        self.navigationController?.popViewController(animated: true)
    }
}
