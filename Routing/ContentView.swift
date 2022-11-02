//
//  ContentView.swift
//  Routing
//
//  Created by Tero Jankko on 11/1/22.
//

import SwiftUI
import MapKit

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
            .accentColor(.green)
            .onAppear() {
                viewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
