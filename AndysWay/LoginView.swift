//
//  ContentView.swift
//  AndysWay
//
//  Created by Christian Grise on 9/27/24.
//

import SwiftUI
import SwiftData

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showPassword: Bool = false
    
    var isSignInButtonDisabled: Bool {
        [email, password].contains(where: \.isEmpty)
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Spacer()
            
            Text("Andy's Way")
                .font(.title)
                .bold()
                .foregroundColor(Color(.primary))
            
            Image(.icon)
                .resizable()
                .frame(width: 100, height: 100)
                .frame(maxWidth: 100)
            
            Spacer()
            
            TextField("Email",
                      text: $email,
                      prompt: Text("Email").foregroundColor(Color(.primary))
            )
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.primary), lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack{
                Group {
                    if showPassword {
                        TextField("Password",
                                  text: $password,
                                  prompt: Text("Password").foregroundColor(Color(.primary)))
                    } else {
                        SecureField("Password",
                                    text: $password,
                                    prompt: Text("Password").foregroundColor(Color(.primary)))
                    }
                }
                .padding(10)
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.primary), lineWidth: 2)
                }
                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(Color(.primary))
                }
            }
            .padding(.horizontal)
            Spacer()
            Button(action: {
                print("Log in!")
            }) {
                Text("Log in")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(
                isSignInButtonDisabled ? Color(.gray) : Color(.primary)
            )
            .cornerRadius(20)
            .disabled(isSignInButtonDisabled)
            .padding()
        }
    }
}

#Preview {
    LoginView()
        .modelContainer(for: Item.self, inMemory: true)
}
