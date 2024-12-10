//
//  MarkersEndPoint.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

struct MarkersResponse: Decodable {
}

struct MarkersEndPoint: ResourceEndPoint {
    typealias Response = MarkersResponse
    
    static var path: String = "/markers"
    
    static var availableHTTPMethods: [HTTPMethod] = [.GET, .PUT, .POST]
    
    static func fetchMarkers(completion: @escaping (Result<[MyMarker], Error>) -> Void) {
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
                let markers = try JSONDecoder().decode([MyMarker].self, from: data)
                completion(.success(markers))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func addMarker(marker: MyMarker, completion: @escaping (Result<MyMarker, Error>) -> Void) {
        let fullPath =  currentEnvironment.url.absoluteString.appending(path)
        guard let url = URL(string: fullPath) else {
            completion(.failure(GofurError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.httpBody = marker.toJSONData()
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
                let marker = try JSONDecoder().decode(MyMarker.self, from: data)
                completion(.success(marker))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
