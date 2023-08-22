//
//  DetailsView.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import SwiftUI

struct DetailsView: View {
    static let imageSize = UIScreen.main.bounds.width * 0.5
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.fixed(0.5)),
        GridItem(.flexible(), spacing: 0),
        GridItem(.fixed(0.5)),
        GridItem(.flexible(), spacing: 0)
    ]
    
    
    @ObservedObject private var pokemonDetail: DetailsViewModel
    let onBack: () -> Void
    let onPressNext: () -> Void
    let onPressPrevious: () -> Void
    let hasPrevious: Bool
    let hasNext: Bool
    
    init(id: String, onBack: @escaping () -> Void, onPressNext: @escaping () -> Void, onPressPrevious: @escaping () -> Void, hasPrevious: Bool, hasNext: Bool) {
        self.onBack = onBack
        self.onPressNext = onPressNext
        self.onPressPrevious = onPressPrevious
        self.pokemonDetail = DetailsViewModel(id: id)
        self.hasPrevious = hasPrevious
        self.hasNext = hasNext
    }
    
    var body: some View {
        VStack {
            if let pokemonData = pokemonDetail.data {
                
                // MARK: Header
                HStack {
                    Button(action: onBack) {
                        Image(systemName: "arrow.left").font(.title2)
                    }
                    Text(pokemonData.name.capitalized).font(.title2)
                    Spacer()
                    Text("#\(pokemonData.id)")
                }
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                
                // MARK: Image
                HStack(alignment: .bottom) {
                    
                    if hasPrevious {
                        Button(action: onPressPrevious) {
                            Image(systemName: "chevron.left").foregroundColor(.white).fontWeight(.bold)
                        }
                    }
                    
                    Spacer()
                    if let imageUrl = pokemonData.sprites.other.officialArtwork.front_default {
                        AsyncImage(url: URL(string: imageUrl)) { phase in
                            switch (phase) {
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: DetailsView.imageSize,  height: DetailsView.imageSize)
                            default:
                                EmptyView().frame(width: DetailsView.imageSize, height: DetailsView.imageSize)
                            }
                        }
                    } else {
                        EmptyView().frame(width: PokemonCard.imageSize, height: PokemonCard.imageSize)
                    }
                    Spacer()
                    
                    if hasNext {
                        Button(action: onPressNext) {
                            Image(systemName: "chevron.right").foregroundColor(.white).fontWeight(.bold)
                        }
                    }
                }
                .padding(.bottom, 16)
                .padding(.horizontal, 8)
                
                // MARK: Content
                VStack {
                    
                    // MARK: Types
                    HStack {
                        ForEach(pokemonData.types) { pokemonType in
                            Text(pokemonType.type.name.capitalized)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 4)
                                .background(pokemonType.type.color)
                                .cornerRadius(32)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.caption)
                        }
                    }
                    .foregroundColor(Color.black)
                    
                    
                    // MARK: Details
                    Text("About")
                        .foregroundColor(pokemonData.color)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                    Grid(alignment: .leading, verticalSpacing: 0) {
                        GridRow {
                            LazyVGrid(columns: columns) {
                                Text(pokemonData.formattedWeight).font(.subheadline).fontWeight(.bold)
                                Rectangle()
                                Text(pokemonData.formattedHeight).font(.subheadline).fontWeight(.bold)
                                Rectangle()
                                Text(pokemonData.joinedAbilities).font(.subheadline).fontWeight(.bold)
                            }
                        }
                        GridRow {
                            LazyVGrid(columns: columns) {
                                Text("Weight").font(.caption).padding(.top, 8)
                                Rectangle()
                                Text("Height").font(.caption).padding(.top, 8)
                                Rectangle()
                                Text("Abilities").font(.caption).padding(.top, 8)
                            }
                        }
                    }
                    
                    // MARK: Base Stats
                    Text("Base Stats")
                        .foregroundColor(pokemonData.color)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 16)
                    Grid(alignment: .leading, verticalSpacing: 0) {
                        ForEach(pokemonData.stats) { stat in
                            GridRow {
                                Text(formatBaseStatTitle(stat: stat.stat.name))
                                    .foregroundColor(pokemonData.color)
                                    .fontWeight(.bold)
                                Divider().background(Color.black).rotationEffect(.degrees(90)).frame(width: 20)
                                Text(String(stat.base_stat))
                                ProgressView(value: Double(stat.base_stat), total: 100)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .accentColor(pokemonData.color)
                            }
                        }
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(16)
                .background(Color.white)
                .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
        .background(pokemonDetail.data?.color ?? Color.white)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(
            id: PokemonListItem.sampleData.name,
            onBack: { print("On Back") },
            onPressNext: { print("On Press Next") },
            onPressPrevious: { print("On Press Previous") },
            hasPrevious: true,
            hasNext: true
        )
    }
}
