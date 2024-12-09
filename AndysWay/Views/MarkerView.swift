//
//  MarkerView.swift
//  AndysWay
//
//  Created by Christian Grise on 10/28/24.
//

import Foundation
import SwiftUI

public struct MarkerView: View {
    
    @State var marker: MyMarker
    
    public var body: some View {
        marker.type.markerImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}
