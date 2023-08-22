//
//  ContentView.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import SwiftUI

struct HomeView: View {
    static let gridSize = UIScreen.main.bounds.width / 2
    static let pagePadding: CGFloat = 8
    
    @StateObject private var viewModel = HomeViewModel()
    
    let column: [GridItem] = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )
    
    var body: some View {
        ScrollView {
            TextField("Search name", text: $viewModel.searchInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: viewModel.searchInput) { search in
                    viewModel.onSearch(search: search)
                }
                .padding(.horizontal, HomeView.pagePadding)
            

            let data = viewModel.searchInput.count > 0 ? viewModel.filteredResults : viewModel.results
            
            LazyVGrid(columns: column, spacing: 8) {
                ForEach(Array(data.enumerated()), id: \.element.name) { index, pokemon in
                    Button(action: { viewModel.onPressCard(index: index) }) {
                        PokemonCard(pokemon: pokemon)
                            .frame(width: HomeView.gridSize - HomeView.pagePadding * 2, height: PokemonCard.cardHeight)
                    }
                    .onAppear() {
                        if index == data.count - 1 {
                            viewModel.fetchData()
                        }
                    }
                }
            }.padding(.all, HomeView.pagePadding)
        }
        
        .sheet(isPresented: $viewModel.showDetails) {
            DetailsView(
                id: viewModel.results[viewModel.activeIndex!].name,
                onBack: viewModel.onResetActiveIndex,
                onPressNext: viewModel.onPressNext,
                onPressPrevious: viewModel.onPressPrevious,
                hasPrevious: viewModel.hasPrevious,
                hasNext: viewModel.hasNext
            )
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
