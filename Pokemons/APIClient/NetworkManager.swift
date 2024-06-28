//
//  NetworkManager.swift
//  Pokemons
//
//  Created by Дарья Балацун on 25.06.24.
//

import Foundation

// Primary API service object to get Pokemons data
final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    enum NetworkError: Error {
        case invalidUrl
        case invalidData
        case invalidJSONData
    }
    
    public func fetchData<T: Decodable>(
        url: URL?,
        expecting: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.invalidData))
                }
                return
            }
            
            do {
                let _ = try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print("Received invalid JSON data for \(url)")
                completion(.failure(NetworkError.invalidJSONData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(expecting, from: data)
                completion(.success(result))
            } catch {
                if let dataString = String(data: data, encoding: .utf8) {
                    print("Error \(error.localizedDescription) for url: \(url) with data: \(dataString)")
                }
                completion(.failure(error))
            }
        }
        task.resume() 
    }
}


