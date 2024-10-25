//
//  Untitled.swift
//  AndysWay
//
//  Created by Christian Grise on 10/24/24.
//

import SwiftUI

struct TabBarView: View {
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                HomeView()
                    .environmentObject(HomeViewModel())
                    .navigationBarTitle("Home")
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            NavigationStack {
                MapView()
                    .environmentObject(MapViewModel())
                    .navigationBarTitle("Map")
            }
            .tabItem {
                Label("Map", systemImage: "map")
            }
            NavigationStack {
                ProfileView()
                    .environmentObject(ProfileViewModel())
                    .navigationBarTitle("Profile")
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}


#Preview {
    TabBarView()
}
