//
//  AddMarkerView.swift
//  AndysWay
//
//  Created by Christian Grise on 10/28/24.
//

import Foundation
import SwiftUI

struct AddMarkerView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedAddMarkerType: MyMarkerType?
    
    var addMarkerFunction: (MyMarker) -> Void
    
    var markerTypes = MyMarkerType.allCases
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Add a marker")
                .font(.title3)
                .padding(.horizontal)
            
            Divider()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 44), spacing: 10)]) {
                    ForEach(markerTypes) { markerType in
                        ZStack {
                            let marker = MyMarker(type: markerType)
                            markerType == selectedAddMarkerType ? Color.red.opacity(0.2) : .clear
                            MarkerView(marker: marker)
                                .draggable(marker)
                                .onTapGesture {
                                    selectedAddMarkerType = marker.type
                                }
                        }
                    }
                }.padding()
            }
            
            Divider()
            
            Button("Add at my location") {
                if selectedAddMarkerType != nil {
                    self.addMarkerFunction(MyMarker(type: selectedAddMarkerType!))
                    selectedAddMarkerType = nil
                    dismiss()
                } else {
                    print("No marker type selected")
                }
            }
        }
        .presentationCompactAdaptation(.none)
        .padding(.vertical)
    }
}

