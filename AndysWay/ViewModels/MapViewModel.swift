//
//  MapViewModel.swift
//  AndysWay
//
//  Created by Christian Grise on 10/25/24.
//

import Foundation

class MapViewModel: ObservableObject {
    @Published var markers: [MyMarker] = []
    @Published var filteredMarkers: [MyMarker] = []
    
    var markerTypes = MyMarkerType.allCases
    @Published var selectedFilterMarkerTypes: [MyMarkerType] = []
    
    private let session = URLSession(configuration: .default)
    
    func clearSelectedMarkerTypes() {
        selectedFilterMarkerTypes.removeAll()
        selectedFilterMarkerTypes.append(contentsOf: markerTypes)
    }
    
    func fetchMapMarkers(completion: @escaping (Result<[MyMarker], Error>) -> Void) {
        MarkersEndPoint.fetchMarkers() { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.markers = response//.markers
                    self.filterMarkers()
                    print("Successfully fetched map markers: \(response.count)")
                    completion(.success(self.markers))
                }
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
                print("Error adding marker: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func filterMarkers() {
        if selectedFilterMarkerTypes.isEmpty {
            filteredMarkers = markers
        } else {
            filteredMarkers = markers.filter( { selectedFilterMarkerTypes.contains($0.type) })
        }
    }
}
