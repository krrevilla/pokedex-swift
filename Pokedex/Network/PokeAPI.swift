//
//  PokeAPI.swift
//  Pokedex
//
//  Created by Karl Revilla on 21/8/2023.
//

import Foundation

final class PokeAPI {
    private let basePokeAPIUrl = "https://pokeapi.co/api/v2"
    
    func callAPI<T: Codable>(for type: T.Type, url: String, completionHandler: @escaping (T?) -> Void) {
        guard let url = URL(string: basePokeAPIUrl + url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completionHandler(result)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
        }
        
        task.resume()
    }
}
