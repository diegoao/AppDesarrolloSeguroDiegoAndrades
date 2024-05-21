//
//  PokemonHome.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import SwiftUI

struct PokemonHome: View {
     
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var cargarInfoPokemon : Bool = false
    
    var body: some View {
        ZStack {
            // Fondo2
            Image(decorative: "Fondo2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            
            // Logo
            VStack {
                Image(decorative: "Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Spacer()
                
                ProgressView() // Spinner de carga
                         .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                         .scaleEffect(3.0)
                Spacer()
                Text("Práctica Desarrollo Seguro")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color(.blue))
                Text("Diego Andrades Oñate")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color(.blue))
            }
            
        
        }
        .onAppear{
            Task {
               let datos =  await rootViewModel.onPokemon() { readError in
                    DispatchQueue.main.async {
                        switch readError {
                        case .serverError:
                            print("Server error pop up")
                        case .unknownError:
                            print("Unknown error pop up")
                        case .none:
                            print("Chargue Data Pokemon")
                            self.cargarInfoPokemon = true

                        }
                    }
                }
                
                if self.cargarInfoPokemon{
                    guard let data = datos.first?.results else {
                        print("Error dispatch data from Pokemon")
                        return
                    }
                    for dato in data {
                        rootViewModel.listInfoPokemon.append(await rootViewModel.onListPokemon(dataPoke: dato))
                    }
                    rootViewModel.status = .loaded
                }
            }
        }
    }
}


#Preview {
    PokemonHome()
}
