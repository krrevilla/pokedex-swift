//
//  Utils.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import SwiftUI
import Foundation

func getTypeColor(pokeType: String) -> Color {
    switch pokeType {
    case "bug":
        return Color("Bug")
    case "dark":
        return Color("Dark")
    case "dragon":
        return Color("Dragon")
    case "electric":
        return Color("Electric")
    case "fairy":
        return Color("Fairy")
    case "fighting":
        return Color("Fighting")
    case "fire":
        return Color("Fire")
    case "flying":
        return Color("Flying")
    case "ghost":
        return Color("Ghost")
    case "grass":
        return Color("Grass")
    case "ground":
        return Color("Ground")
    case "ice":
        return Color("Ice")
    case "poison":
        return Color("Poison")
    case "psychic":
        return Color("Psychic")
    case "rock":
        return Color("Rock")
    case "steel":
        return Color("Steel")
    case "water":
        return Color("Water")
    default:
        return Color("Normal")
    }
}

func formatBaseStatTitle(stat: String) -> String {
    switch stat {
    case "hp":
        return "HP"
    case "attack":
        return "ATK"
    case "defense":
        return "DEF"
    case "special-attack":
        return "SATK"
    case "special-defense":
        return "SDEF"
    case "speed":
        return "SPD"
    case "accuracy":
        return "ACC"
    case "evasion":
        return "EVA"
    default:
        return stat
    }
}
