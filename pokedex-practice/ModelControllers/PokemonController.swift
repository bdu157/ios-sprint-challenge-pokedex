//
//  PokemonController.swift
//  pokedex-practice
//
//  Created by Dongwoo Pae on 6/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case otherError
    case badData
    case noImage
}



class PokemonController {
    
    var pokemons: [Pokemon] = []
    
    var baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    //performSearch with searchTerm
    func performSearch(for searchTerm: String, completion:@escaping (Pokemon?, Error?) -> Void) {

        let performURL = baseURL.appendingPathComponent("pokemon/\(searchTerm.lowercased())")
        
        var request = URLRequest(url: performURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let jsonData = try jsonDecoder.decode(Pokemon.self, from: data)
                completion(jsonData, nil)
            } catch {
                NSLog("There is an error in decoindg")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    
    //fetchImage with sprites(imageURL)
    func fetchImage(at urlString: String, completion:@escaping(Result<UIImage, NetworkError>)->Void) {
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
            guard let image = UIImage(data: data) else {
                completion(.failure(.noImage))
                return
            }
            completion(.success(image))
        }.resume()
    }
    
    //createPokemon
    func createPokemon (for pokemon: Pokemon) {
        self.pokemons.append(pokemon)
    }
    
    //deletePokemon
    func deletePokemon (for pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(of: pokemon) else {return}
            pokemons.remove(at: index)
    }
}
