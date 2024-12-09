//
//  MapView.swift
//  AndysWay
//
//  Created by Christian Grise on 10/24/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @EnvironmentObject private var model: MapViewModel
    
    @StateObject var locationManager = LocationManager()
    
    @State var isAddMarkerPopoverPresented = false
    @State var isFilterMarkersPopoverPresented = false
    
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: 1)
    
    @State var selectedAddMarkerType: MyMarkerType? = nil
    
    var body: some View {
        NavigationStack {
            Map(
                coordinateRegion: $locationManager.region,
                showsUserLocation: true,
                annotationItems: model.filteredMarkers) { marker in
                    mark(for: marker)
                }
                .task {
                    refreshMarkers()
                }
                .dropDestination(for: MyMarker.self) { items, location in
                    let marker = items[0]
//                    marker.latitude = location.x //CONVERT TO MAP LATITUDE
//                    marker.longitude = location.y //CONVERT TO MAP LONGITUDE
                    model.markers.append(items[0])
                    print("Dropped \(marker) at \(location)")
                    return true
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.isFilterMarkersPopoverPresented = true
                }) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }.popover(isPresented: $isFilterMarkersPopoverPresented) {
                    FilterMarkersView(selectedFilterMarkerTypes: $model.selectedFilterMarkerTypes, filterMarkersFunction: self.filterMarkers)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    self.isAddMarkerPopoverPresented = true
                }) {
                    Label("Filter", systemImage: "plus")
                }.popover(isPresented: $isAddMarkerPopoverPresented) {
                    AddMarkerView(selectedAddMarkerType: $selectedAddMarkerType, addMarkerFunction: self.addMarker)
                }
            }
        }
    }
    
    func refreshMarkers() { 
        model.fetchMapMarkers() { _ in
            print("Markers refreshed")
        }
    }
    
    func addMarker(_ marker: MyMarker) {
        var myMarker = marker
        locationManager.getCurrentLocation()
        if let userLocation = locationManager.userLocation {
            myMarker.latitude = userLocation.coordinate.latitude
            myMarker.longitude = userLocation.coordinate.longitude
            print("Add \(selectedAddMarkerType!.rawValue) marker at (\(String(describing: myMarker.latitude)), \(String(describing: myMarker.longitude)))")
            model.addMarker(myMarker) { _ in 
                refreshMarkers()
            }
        }
    }
    
    func filterMarkers(_ markerTypes: [MyMarkerType]) {
        model.selectedFilterMarkerTypes = markerTypes
    }
    
    func mark(for marker: MyMarker) -> some MapAnnotationProtocol {
        let coordinate = CLLocationCoordinate2D(latitude: marker.latitude ?? 0, longitude: marker.longitude ?? 0)
        print("Marker: \(marker.id!) - \(marker.type.rawValue)")
        switch marker.type {
        case .water:
            return MapAnnotation(coordinate: coordinate) {
                Image(systemName: "drop.fill")
            }
        case .trash:
            return MapAnnotation(coordinate: coordinate) {
                Image(systemName: "trash.fill")
            }
        case .light:
            return MapAnnotation(coordinate: coordinate) {
                Image(systemName: "lightbulb.fill")
            }
        case .attack:
            return MapAnnotation(coordinate: coordinate) {
                Image(systemName: "exclamationmark.triangle.fill")
            }
        }
    }
}

#Preview {
    MapView()
}
