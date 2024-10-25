//
//  MapViewModel.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

class MapViewModel: ObservableObject {
    var markers: [Marker] = []
    var filteredMarkers: [Marker] {
        if selectedMarkers.isEmpty {
            return markers
        } else {
            return markers.filter( { selectedMarkers.contains($0.type) })
        }
    }
    
    @Published var cuisines: [String] = []
    @Published var selectedMarkers: [String] = []
    
    private let session = URLSession(configuration: .default)
    
    func clearSelectedMarkers() {
        selectedMarkers.removeAll()
        selectedMarkers.append(contentsOf: cuisines)
    }
    
    func toggleSelectedCuisine(_ markerType: String) {
        if selectedMarkers.contains(markerType) {
            selectedMarkers.removeAll(where: { $0 == markerType })
        } else {
            selectedMarkers.append(markerType)
        }
    }
    
    func fetchMapMarkers(completion: @escaping (Result<[Marker], Error>) -> Void) {
        MarkersEndPoint.fetchMarkers() { result in
            switch result {
            case .success(let response):
                self.markers = response//.markers
                print("Successfully fetched map markers: \(response.count)")
            case .failure(let error):
                print("Error fetching map markers: \(error)")
            }
        }
    }
}
