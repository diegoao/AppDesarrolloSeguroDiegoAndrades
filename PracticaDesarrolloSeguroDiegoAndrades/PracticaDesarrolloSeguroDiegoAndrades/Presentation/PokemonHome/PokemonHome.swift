//
//  PokemonHome.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 19/5/24.
//

import SwiftUI
import LocalAuthentication

struct PokemonHome: View {
     
    @EnvironmentObject var rootViewModel: RootViewModel
    @State var cargarInfoPokemon : Bool = false
    @State private var isLoading: Bool = false
    let authentication: Authentication
    init(){
        self.authentication = Authentication(context: LAContext())
    }
    
    var body: some View {
        ZStack {
            // Fondo2
            Image(decorative: "Fondo2")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.9)
            
            // Logo
            Spacer()
            
            Spacer()
            VStack {
                Image(decorative: "Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Spacer()
                if self.isLoading {
                    ProgressView() // Spinner de carga
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(3.0)
                }
                Spacer()
                VStack{
                    Button(action: {
                        authentication.authenticateUser { isUserAuthenticated in
                            if !isUserAuthenticated {
                                print("Error authentication face ID")
                            }else {
                                Task {
                                    let datos =  await rootViewModel.onPokemon() { readError in
                                        DispatchQueue.main.async {
                                            switch readError {
                                            case .serverError:
                                                print("Server error")
                                            case .unknownError:
                                                print("Unknown error")
                                            case .none:
                                                print("Chargue Data Pokemon")
                                                self.cargarInfoPokemon = true
                                                self.isLoading = true
                                                
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
                        
                    }, label: {
                        Text("Entrar")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 138, height: 40)
                            .background(Color(uiColor: UIColor(red: 128/255, green: 0/255, blue: 70/255, alpha: 1.0))) // Color background
                            .cornerRadius(8.0)
                            .shadow(radius: 10.0, x: 20, y: 10)
                    })
                }
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
    }
}


#Preview {
    PokemonHome()
}
