//
//  RootView.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import SwiftUI

struct RootView: View {

    // MARK: - Properties
    @EnvironmentObject var rootViewModel: RootViewModel

    var body: some View {
        switch (rootViewModel.status) {
        case Status.none:
            PokemonListView()
            
        case Status.loading:
            Text("Loading")
            
        case Status.loaded:
            Text("cargado")
        }
    }
}

#Preview {
    RootView()
}
 