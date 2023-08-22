//
//  DetailsModel.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import SwiftUI
import Foundation

struct Sprites: Codable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
    let other: SpritesOther
}

struct SpritesOther: Codable {
    let officialArtwork: SpritesOtherOfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct SpritesOtherOfficialArtwork: Codable {
    let front_default: String?
    let front_shiny: String?
}

struct AbilitiesItem: Codable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Codable {
    let name: String
    let url: String
}

struct StatItem: Codable, Identifiable {
    let base_stat: Int
    let effort: Int
    let stat: Stat
}

struct Stat: Codable {
    let name: String
    let url: String
}

struct PokeTypeItem: Codable, Identifiable {
    let slot: Int
    let type: PokeType
}

struct PokeType: Codable {
    let name: String
    let url: String
}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let height: Int
    let weight: Int
    let abilities: [AbilitiesItem]
    let stats: [StatItem]
    let types: [PokeTypeItem]
}

extension Sprites {
    static let sampleData: Sprites = Sprites(
        back_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
        back_female: nil,
        back_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/1.png",
        back_shiny_female: nil,
        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
        front_female: nil,
        front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png",
        front_shiny_female: nil,
        other: SpritesOther.sampleData
    )
}

extension SpritesOther {
    static let sampleData: SpritesOther = SpritesOther(officialArtwork: SpritesOtherOfficialArtwork.sampleData)
}

extension  SpritesOtherOfficialArtwork {
    static let sampleData: SpritesOtherOfficialArtwork = SpritesOtherOfficialArtwork(
        front_default: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
        front_shiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/1.png"
    )
}

extension Ability {
    static let sampleData: Ability = Ability(
        name: "overgrow",
        url: "https://pokeapi.co/api/v2/ability/65/"
    )
}

extension AbilitiesItem {
    static let sampleData: AbilitiesItem = AbilitiesItem(ability: Ability.sampleData, is_hidden: false, slot: 1)
}

extension StatItem {
    var id: String {
        stat.name
    }
    
    static let sampleData: StatItem = StatItem(base_stat: 45, effort: 0, stat: Stat.sampleData)
}

extension Stat {
    static let sampleData: Stat = Stat(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
}

extension PokeTypeItem {
    var id: String {
        type.name
    }
    
    static let sampleData: PokeTypeItem = PokeTypeItem(slot: 1, type: PokeType.sampleData)
}

extension PokeType {
    var color: Color {
        getTypeColor(pokeType: name)
    }
    
    static let sampleData: PokeType = PokeType(name: "grass", url: "https://pokeapi.co/api/v2/type/12/")
}

extension Pokemon {
    var color: Color {
        if types.count < 1 {
            return Color("Normal")
        }
        
        return getTypeColor(pokeType: types[0].type.name)
    }
    
    var joinedAbilities: String {
        abilities.map {
            $0.ability.name.capitalized
        }.joined(separator: ", ")
    }
    
    var formattedWeight: String {
        String(format: "%.2f", Double(weight) * 0.1) + " kg"
    }
    
    var formattedHeight: String {
        String(format: "%.2f", Double(height) * 0.1) + " m"
    }
    
    static let sampleData: Pokemon = Pokemon(
        id: 1,
        name: "bulbasaur",
        sprites: Sprites.sampleData,
        height: 7,
        weight: 69,
        abilities: [AbilitiesItem.sampleData, AbilitiesItem.sampleData, AbilitiesItem.sampleData, AbilitiesItem.sampleData],
        stats: [StatItem.sampleData],
        types: [PokeTypeItem.sampleData]
    )
}
