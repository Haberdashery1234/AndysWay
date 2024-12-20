//
//  ContentView.swift
//  AndysWay
//
//  Created by Christian Grise on 9/27/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var model: ProfileViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showPassword: Bool = false
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        VStack() {
            Text("Welcome!")
                .font(.title)
                .foregroundColor(Color.black)
                .padding([.top, .bottom], 50)
                .shadow(radius: 6.0, x: 10, y: 10)
            
            Image(.icon)
                .resizable()
                .frame(width: 180, height: 180)
                .clipShape(Circle())
                .overlay(Circle()
                    .stroke(Color.white, lineWidth: 3))
                .shadow(radius: 9.0, x: 20, y: 10)
                .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 5, y: 10)
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(25.0)
                    .shadow(radius: 10.0, x: 5, y: 10)
            }
            .padding([.leading, .trailing], 50)
            Button(action: {} ) {
                Text("Forgot password?")
                    .padding([.leading], 150)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                model.login(username: email, password: password) {response in
                    switch response {
                    case .success(let user):
                        model.loggedInUser = user
                    case .failure(let error):
                        // failure
                        break
                    }
                }
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 200, height: 60)
                    .background(Color(.orange))
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }
            .padding(.top, 50)
            
            Spacer()
            HStack {
                Text("Don't have an account? ")
                    .foregroundColor(.black)
                Button(action: {}) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 50)
        }
    }
    
    //MARK: - methods
    
    
}

#Preview {
    LoginView()
}

