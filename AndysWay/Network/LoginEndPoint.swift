//
//  Login.swift
//  AndysWay
//
//  Created by Christian Grise on 10/2/24.
//

import Foundation

struct LoginEndPoint: ResourceEndPoint {
    
    static var path: String = "/login"
    
    static var availableHTTPMethods: [HTTPMethod] = [.POST]
    
    static func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        let fullPath =  currentEnvironment.url.absoluteString.appending(path)
        guard let url = URL(string: fullPath) else {
            completion(.failure(GofurError.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.POST.rawValue
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        completion(.success(MockUser))
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data else {
//                completion(.failure(GofurError.invalidResponse))
//                return
//            }
//            
//            do {
//                let marker = try JSONDecoder().decode(MyMarker.self, from: data)
//                completion(.success(marker))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
    }

}
