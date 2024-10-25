//
//  MarkersEndPoint.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

struct MarkersEndPoint: ResourceEndPoint {
    typealias Response = LoginResponse
    
    static var path: String = "/markers"
    
    static var availableHTTPMethods: [HTTPMethod] = [.GET]//, .PUT, .POST]
    
    static func fetchMarkers(completion: @escaping (Result<[Marker], Error>) -> Void) {
        let fullPath =  currentEnvironment.url.absoluteString.appending(path)
        guard let url = URL(string: fullPath) else {
            completion(.failure(GofurError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(GofurError.invalidResponse))
                return
            }
            
            do {
                let markers = try JSONDecoder().decode([Marker].self, from: data)
                completion(.success(markers))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
