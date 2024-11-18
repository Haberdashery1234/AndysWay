//
//  MapViewModel.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

class MapViewModel: ObservableObject {
    @Published var markers: [MyMarker] = []
    var filteredMarkerTypes: [MyMarker] {
        if selectedMarkerTypes.isEmpty {
            return markers
        } else {
            return markers.filter( { selectedMarkerTypes.contains($0.type.rawValue) })
        }
    }
    
    @Published var markerTypes: [String] = []
    @Published var selectedMarkerTypes: [String] = []
    
    private let session = URLSession(configuration: .default)
    
    func clearSelectedMarkerTypes() {
        selectedMarkerTypes.removeAll()
        selectedMarkerTypes.append(contentsOf: markerTypes)
    }
    
    func toggleSelectedCuisine(_ markerType: String) {
        if selectedMarkerTypes.contains(markerType) {
            selectedMarkerTypes.removeAll(where: { $0 == markerType })
        } else {
            selectedMarkerTypes.append(markerType)
        }
    }
    
    func fetchMapMarkers(completion: @escaping (Result<[MyMarker], Error>) -> Void) {
        MarkersEndPoint.fetchMarkers() { result in
            switch result {
            case .success(let response):
                self.markers = response//.markers
                print("Successfully fetched map markers: \(response.count)")
                completion(.success(self.markers))
            case .failure(let error):
                print("Error fetching map markers: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func addMarker(_ marker: MyMarker, completion: @escaping (Result<MyMarker, Error>) -> Void) {
        MarkersEndPoint.addMarker(marker: marker) { result in
            switch result {
            case .success:
                print("Successfully added marker: \(marker)")
                completion(.success(marker))
            case .failure(let error):
                print("Error adding marker: \(marker)")
                completion(.failure(error))
            }
        }
    }
}
