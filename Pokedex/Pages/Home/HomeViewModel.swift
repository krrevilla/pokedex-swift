//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let pokeApi = PokeAPI()
    
    @Published var count: Int = 0
    @Published var results: [PokemonListItem] = []
    @Published var filteredResults: [PokemonListItem] = []
    
    @Published var activeIndex: Int?
    @Published var showDetails: Bool = false
    @Published var hasNext: Bool = false
    @Published var hasPrevious: Bool = false
    
    @Published var searchInput = ""
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        pokeApi.callAPI(for: PokemonListSummary.self, url: "/pokemon?offset=\(self.results.count)") { result in
            self.count = result?.count ?? 0
            self.results.append(contentsOf: result?.results ?? [])
        }
    }
    
    private func configurePreviousAndNext(index: Int) {
        hasNext = index + 1 <= results.count - 1
        hasPrevious = index - 1 >= 0
    }
    
    func onSearch(search: String) {
        if search == "" {
            filteredResults = []
        } else {
            filteredResults = results.filter { pokemon in
                pokemon.name.lowercased().contains(search.lowercased())
            }
        }
    }
    
    func onResetActiveIndex() {
        activeIndex = nil
        showDetails = false
    }
    
    func onPressCard(index: Int) {
        activeIndex = index
        configurePreviousAndNext(index: index)
        showDetails = true
    }
    
    func onPressNext() {
        let nextActiveIndex = activeIndex! + 1
        let lastIndex = results.count - 1
        
        guard nextActiveIndex <= lastIndex else {
            return
        }
        
        activeIndex = nextActiveIndex
        configurePreviousAndNext(index: nextActiveIndex)
    }
    
    func onPressPrevious() {
        let nextActiveIndex = activeIndex! - 1
        
        guard nextActiveIndex >= 0 else {
            return
        }
        
        activeIndex = nextActiveIndex
        configurePreviousAndNext(index: nextActiveIndex)
    }
}
