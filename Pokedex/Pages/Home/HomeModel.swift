//
//  HomeModel.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import Foundation

struct PokemonListSummary: Codable {
    let count: Int?
    let results: [PokemonListItem]?
}

struct PokemonListItem: Codable {
    let name: String
    let url: String
}

extension PokemonListSummary {
    static let sampleData: PokemonListSummary = PokemonListSummary(count: 1, results: [PokemonListItem.sampleData])
}

extension PokemonListItem {
    static let sampleData: PokemonListItem = PokemonListItem(name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/")
}
