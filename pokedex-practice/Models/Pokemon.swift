//
//  Pokemon.swift
//  pokedex-practice
//
//  Created by Dongwoo Pae on 6/15/19.
//  Copyright © 2019 Dongwoo Pae. All rights reserved.
//

import Foundation

struct Pokemon: Codable, Equatable {
    let name: String
    let id: Int
    let abilities:[Ability]
    let types: [TypeDictionary]
    let sprites: SpriteImageURL
    
    struct Ability: Codable, Equatable {
        let ability: NestedAbility
        
        struct NestedAbility: Codable, Equatable {
            let name: String
        }
    }

    struct TypeDictionary: Codable, Equatable {
        let type: NestedType
        
        struct NestedType: Codable, Equatable {
            let name: String
        }
    }
    
    struct SpriteImageURL: Codable, Equatable {
        let frontDefault: String
    }
    
}
