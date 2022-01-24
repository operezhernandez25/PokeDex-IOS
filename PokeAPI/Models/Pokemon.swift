//
//  Pokemon.swift
//  PokeAPI
//
//  Created by Oscar Perez on 12/10/21.
//

import Foundation

protocol Displayable {
  //protocol requirements
    var pokemonName: String{get}
    var pokemonUrl: String{get}
}


struct Pokemon: Decodable{
    let name:String
    let url:String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url = "url"
    }
}


extension Pokemon: Displayable {
  var pokemonName: String {
      name 
  }
    
    var pokemonUrl: String{
        url
    }

}


struct Petition: Decodable{
    let count:Int
    let next:String?
    let previous:String?
    let pokemons:[Pokemon]
    
    enum CodingKeys: String, CodingKey{
        case count
        case next
        case previous
        case pokemons = "results"
    }
}

