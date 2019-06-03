//
//  SearchResult.swift
//  ios-pokedex(sprintChallenge3)
//
//  Created by Dongwoo Pae on 6/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation



struct SearchResult: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Type]
    let sprite: Image
}

struct Ability: Codable {
    let ability: Results
    }

struct Type: Codable {
    let type: Results
    }

struct Results: Codable {
    let name: String
    }

struct Image: Codable {
    let frontDefault: String
}


//http://poke-api.co/api/v2/pokemon/name
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
