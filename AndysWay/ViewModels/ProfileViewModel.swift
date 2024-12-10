//
//  ProfileViewModel.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var loggedInUser: User? = nil
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        LoginEndPoint.login(username: username, password: password) { result in
            switch result {
            case .success(let user):
                print("Successfully logged in.")
                completion(.success(user))
            case .failure(let error):
                print("Error adding marker: \(error)")
                completion(.failure(error))
            }
        }
    }
}
