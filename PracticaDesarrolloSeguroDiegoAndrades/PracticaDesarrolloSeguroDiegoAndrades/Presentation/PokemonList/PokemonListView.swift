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
                Text("Pokemon List").font(.title2)
                    .bold()

                
                NavigationStack{
                    List{
                        
                        
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
