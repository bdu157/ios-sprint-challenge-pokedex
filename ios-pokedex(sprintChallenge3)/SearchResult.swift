//
//  SearchResult.swift
//  ios-pokedex(sprintChallenge3)
//
//  Created by Dongwoo Pae on 6/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [pokemonType]
    let sprites: Images
    
    struct Ability: Codable {
        let ability: NestedAbility
        
        struct NestedAbility: Codable {
            let name: String
        }
    }
    
    struct pokemonType: Codable {
        let type: NestedType
        
        struct NestedType: Codable {
            let name: String
        }
    }
    struct Images: Codable {
        let frontDefault: String
    }
}

//https://pokeapi.co/
//http://poke-api.co/api/v2/pokemon/name => this name has to be lowercase
/*
 
 {
 "id": 12,
 "name": "butterfree",
 "base_experience": 178,
 "height": 11,
 "is_default": true,
 "order": 16,
 "weight": 320,
 "abilities": [
                {
                     "is_hidden": true,
                     "slot": 3,
                     "ability": {
                                   "name": "tinted-lens",
                                    "url": "https://pokeapi.co/api/v2/ability/110/"
                                }
                }
            ],
 */
