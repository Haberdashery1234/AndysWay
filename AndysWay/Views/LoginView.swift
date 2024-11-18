//
//  ContentView.swift
//  AndysWay
//
//  Created by Christian Grise on 9/27/24.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var model: LoginViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showPassword: Bool = false
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        if model.isLoggedIn {
            
            VStack() {
                Text("Welcome!")
                    .font(.title)
                    .foregroundColor(Color.white)
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
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    model.login(username: email, password: password)
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color(.orange))
                        .cornerRadius(20.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 50)
                
                Spacer()
                HStack {
                    Text("Don't have an account? ")
                        .foregroundColor(.white)
                    Button(action: {}) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                    }
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(.main), Color(.green)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all))
        } else {
            TabBarView()
        }
    }
    
    //MARK: - methods
    
    
}

#Preview {
    LoginView()
}

