//
//  Endpoint.swift
//  Pokemons
//
//  Created by Дарья Балацун on 25.06.24.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = path
        return components
    }
    
    var request: URLRequest {
        guard let url = urlComponents.url(relativeTo: baseURL) else {
            fatalError("Failed to construct URL from components: \(urlComponents)")
        }
        return URLRequest(url: url)
    }
}

enum EverythingEndpoint: Endpoint {
    case pokemons
    
    var baseURL: URL {
        return PokemonAPI.baseURL
    }
    
    var path: String {
        return "/api/v2/pokemon"
    }
}

enum PokemonAPI {
    static var baseURL: URL {
        return URL(string: "https://pokeapi.co/")!
    }
}


