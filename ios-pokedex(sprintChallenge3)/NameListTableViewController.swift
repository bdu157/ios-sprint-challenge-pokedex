//
//  NameListTableViewController.swift
//  ios-pokedex(sprintChallenge3)
//
//  Created by Dongwoo Pae on 6/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import UIKit

class NameListTableViewController: UITableViewController {
    
    var searchResultController = SearchResultController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultController.pokemons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name = searchResultController.pokemons[indexPath.row]
        cell.textLabel?.text = name.name.capitalized
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let selectedPokemon = self.searchResultController.pokemons[indexPath.row]
        self.searchResultController.deletePokemon(for: selectedPokemon)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearchVCfromSearch" {
            guard let destVC = segue.destination as? SearchDetailViewController else {return}
                destVC.searchResultController = self.searchResultController
        } else if segue.identifier == "ToSearchVCfromCell" {
            guard let destVC = segue.destination as? SearchDetailViewController,
                let selectedRow = tableView.indexPathForSelectedRow else {return}
                destVC.searchResultController = self.searchResultController
                destVC.pokemons = self.searchResultController.pokemons[selectedRow.row]
        }
    }
}
