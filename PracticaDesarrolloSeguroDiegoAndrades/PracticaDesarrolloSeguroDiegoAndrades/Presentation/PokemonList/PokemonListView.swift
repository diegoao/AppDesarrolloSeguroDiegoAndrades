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
                    .onAppear{
                        Task {
                            await rootViewModel.onPokemon() { readError in
                                DispatchQueue.main.async {
                                    switch readError {
                                    case .serverError:
                                        print("Server error pop up")
                                    case .unknownError:
                                        print("Unknown error pop up")
                                    case .none:
                                        print("Navigating to home")
                                        rootViewModel.status = .loaded
                                    }
                                }
                            }
                        }
                    }
                
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
                            .id(2)
                    .background(Color.black.opacity(0.5))
                }
            }
        }
    }


#Preview {
    PokemonListView()
}
