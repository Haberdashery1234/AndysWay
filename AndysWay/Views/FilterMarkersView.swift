//
//  AddMarkerView.swift
//  AndysWay
//
//  Created by Christian Grise on 10/28/24.
//

import Foundation
import SwiftUI

struct FilterMarkersView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedFilterMarkerTypes: [MyMarkerType]
    
    var filterMarkersFunction: ([MyMarkerType]) -> Void
    
    var markerTypes = MyMarkerType.allCases
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Button("Show All") {
                
                selectedFilterMarkerTypes.removeAll()
                selectedFilterMarkerTypes.append(contentsOf: markerTypes)
            }
            
            Divider()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 10)]) {
                    ForEach(markerTypes) { markerType in
                        ZStack {
                            let marker = MyMarker(id: UUID(), type: markerType)
                            selectedFilterMarkerTypes.contains { $0 == markerType } ? .clear : Color.red.opacity(0.2)
                            MarkerView(marker: marker)
                                .onTapGesture {
                                    if selectedFilterMarkerTypes.contains(marker.type) {
                                        selectedFilterMarkerTypes.removeAll { $0 == marker.type }
                                    } else {
                                        selectedFilterMarkerTypes.append(marker.type)
                                    }
                                    print("\(selectedFilterMarkerTypes)")
                                }
                        }
                    }
                }.padding()
            }
        }
        .presentationCompactAdaptation(.none)
        .padding(.vertical)
    }
}

