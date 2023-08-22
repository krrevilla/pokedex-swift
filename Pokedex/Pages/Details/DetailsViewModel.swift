//
//  DetailsViewModel.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import Foundation

class DetailsViewModel: ObservableObject {
    private let pokeApi = PokeAPI()
    
    @Published var data: Pokemon?
    
    init(id: String) {
        fetchData(id)
    }
    
    func fetchData(_ id: String) {
        pokeApi.callAPI(for: Pokemon.self, url: "/pokemon/\(id)") { result in
            self.data = result
        }
    }
}
