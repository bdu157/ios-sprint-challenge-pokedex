//
//  MainTableViewController.swift
//  pokedex-practice
//
//  Created by Dongwoo Pae on 6/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    var pokemonController = PokemonController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemons.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pokemon = pokemonController.pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.name.capitalized
        return cell
    }
 


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedPokemon = self.pokemonController.pokemons[indexPath.row]
        self.pokemonController.deletePokemon(for: selectedPokemon)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVCfromSearch" {
            guard let destVC = segue.destination as? DetailViewController else {return}
                destVC.pokemonController = self.pokemonController
        } else if segue.identifier == "ToDetailVCfromCell" {
            guard let destVC = segue.destination as? DetailViewController,
                let selectedRow = self.tableView.indexPathForSelectedRow else {return}
                let pokemon = self.pokemonController.pokemons[selectedRow.row]
                destVC.pokemonController = self.pokemonController
                destVC.pokemon = pokemon
        }
    }

}
