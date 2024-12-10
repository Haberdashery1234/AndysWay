//
//  ProfileView.swift
//  AndysWay
//
//  Created by Christian Grise on 10/24/24.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var model: ProfileViewModel
    
    var body: some View {
        if let user = model.loggedInUser {
            VStack(spacing: 20) {
                // Profile Image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .shadow(radius: 10)
                
                // Name and Title
                Text(user.displayName)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let location = user.location {
                    Text("\(location)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    VStack {
                        Text("\(user.friends)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Pack Pals")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    VStack {
                        Text("\(user.addedMarkers.count)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Markers Added")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .background(Color(.systemGroupedBackground))
        } else {
            LoginView()
        }
    }
}

#Preview {
    ProfileView()
}
