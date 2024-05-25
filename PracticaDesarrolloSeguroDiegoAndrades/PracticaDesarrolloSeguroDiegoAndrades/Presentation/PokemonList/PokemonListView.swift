//
//  PokemonListView.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {

        VStack{
            Text("title1").font(.title2)
                .bold()
            
            NavigationStack{
                List{
                    let pokemon = rootViewModel.listInfoPokemon
                    //MARK: - Se crean celdas personalizadas por cada pokemon
                    if  !pokemon.isEmpty {
                        ForEach(pokemon.indices, id: \.self) { index in
                            let poke = pokemon[index]
                            PokemonRowView(pokemon: poke)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.white.opacity(0)) // Elimino el color de fondo de la lista
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(
                    Image("Fondo1")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.8))
                .background(Color.black.opacity(0.5))
            }
        }
    }
}





#Preview {
    PokemonListView()
}

