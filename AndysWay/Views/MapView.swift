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
    
    var body: some View {
        Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            annotationItems: model.markers) { marker in
                mark(for: marker)
            }
            .popover(isPresented: $isAddMarkerPopoverPresented) {
                markerTypes
            }
            .task {
                refreshMarkers()
            }
    }
    
    var markerTypes: some View {
        VStack(alignment: .leading) {
            Text("Add a marker")
                .font(.title3)
                .padding(.horizontal)
            
            Divider()
            
//            ScrollView {
//                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 10)]) {
//                    ForEach(MarkerType.) { index in
//                        Text("\(index)")
//                    }
//                }.padding()
//            }
        }
        .padding(.vertical)
    }
    
    func refreshMarkers() {
        model.fetchMapMarkers() { _ in
        }
    }
    
    func mark(for marker: Marker) -> MapAnnotation {
        switch marker.type {
        case "water":
            return AnyMapAnnotationProtocol(MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longitude))) {
                Image("drop")
            }
        default:
            return AnyMapAnnotationProtocol(MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longitude))) {
                Image("circle")
            }
        }
    }
}

#Preview {
    MapView()
}
