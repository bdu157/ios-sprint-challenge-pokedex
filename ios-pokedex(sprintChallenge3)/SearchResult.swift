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
    let name: String
    let id: Int
    let ability: String
    let types: String
}


struct SearchResults: Codable {
    let results: [SearchResult]
}
