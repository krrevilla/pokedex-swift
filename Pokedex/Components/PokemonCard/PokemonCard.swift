//
//  PokemonCard.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import SwiftUI

struct PokemonCard: View {
    static let cardHeight: CGFloat = 80
    static let imageSize: CGFloat = 65
    
    
    let pokemon: PokemonListItem
    @ObservedObject private var pokemonDetail: DetailsViewModel
    
    init(pokemon: PokemonListItem) {
        self.pokemon = pokemon
        self.pokemonDetail = DetailsViewModel(id: pokemon.name)
    }
    
    var body: some View {
        HStack {
            if let pokemonData = pokemonDetail.data {
                Text(pokemonData.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Spacer()
                
                if let imageUrl = pokemonData.sprites.other.officialArtwork.front_default {
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch (phase) {
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: PokemonCard.imageSize,  height: PokemonCard.imageSize)
                        default:
                            EmptyView().frame(width: PokemonCard.imageSize, height: PokemonCard.imageSize)
                        }
                    }
                } else {
                    EmptyView().frame(width: PokemonCard.imageSize, height: PokemonCard.imageSize)
                }
                
            } else {
                EmptyView().frame(width: PokemonCard.imageSize, height: PokemonCard.imageSize)
                Spacer()
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .background(pokemonDetail.data?.color ?? Color.white)
        .cornerRadius(10)
        .shadow(color: Color(white: 0.5, opacity: 0.5), radius: 1, x: 0, y: 4)
    }
}

struct PokemonCard_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCard(pokemon: PokemonListItem.sampleData)
            .previewLayout(.fixed(width: HomeView.gridSize, height: PokemonCard.cardHeight))
    }
}
