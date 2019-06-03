//
//  SearchResult.swift
//  ios-pokedex(sprintChallenge3)
//
//  Created by Dongwoo Pae on 6/1/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation


//i will need to figure out more i have not found actuall set up of what i am bringing into (Decoding) from API yet

struct SearchResult: Codable {
    let id: Int
    let name: String
    let abilities: [Ability]
    let types: [Type]
    let sprite: String
}

struct Ability: Codable {
    let ability: Results
}

struct Type: Codable {
    let type: Results
}

struct Results: Codable {
    let name: String
    let url: String
}


//http://poke-api.co/api/v2/pokemon/name
