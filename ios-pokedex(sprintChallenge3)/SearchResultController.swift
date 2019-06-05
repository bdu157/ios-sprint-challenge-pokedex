//
//  SearchResultController.swift
//  ios-pokedex(sprintChallenge3)
//
//  Created by Dongwoo Pae on 6/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
}

class SearchResultController {

    var pokemons : [Pokemon] = []
    
    
    func createPokemons(for result: Pokemon) {
        self.pokemons.append(result)
    }
    
    func deletePokemon(for pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(of: pokemon) else {return}
            self.pokemons.remove(at: index)
    }
    
    
    
    let basicURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    func perfomSearch(for searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        
        
    
        let pokemonURL = basicURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let pokemon = try decoder.decode(Pokemon.self, from:data)
              //  self.pokemons = [pokemon]   same as below
             // self.pokemons.append(pokemon)  //this is just being appeneded when search occurs but we need to append this when save button is clicked
                completion(pokemon, nil)
            } catch {
                print(error)
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    
    //fetching the image
    func fetchImage(at urlString: String, completion: @escaping (Result<UIImage, NetworkError>)->Void) {
        let imageURL = URL(string: urlString)!
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            let image = UIImage(data: data)!
            completion(.success(image))
        } .resume()
    }

}
