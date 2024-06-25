//
//  NetworkManager.swift
//  Pokemons
//
//  Created by Дарья Балацун on 25.06.24.
//

import Foundation

// Primary API service object to get Pokemons data
final class NetworkManager {
// Shared singleton instance
    static let shared = NetworkManager()
// Privatized constructor
    private init() {}
// Send Pokemons API Call
// Parameters:
//  - request: Request instance
//  - completion: Callback with data or error
    public func fetchData(_ request: Request, completion: @escaping () -> Void) {
        
    }
}
