//
//  PokemonRowView.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 21/5/24.
//

import SwiftUI


struct PokemonRowView: View {
    
    @EnvironmentObject var rootViewModel: RootViewModel
    var pokemon: PokemonInfoModel
    @State private var text: String = ""

    var body: some View {
        
        ZStack(alignment: .topLeading ){
 
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 362, height: 480)
                .cornerRadius(30)

            VStack{
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(Color.yellow.opacity(0.4))
                            .frame(width:350, height: 35)
                            .cornerRadius(30)
                        Text("\(pokemon.species.name.uppercased())")
                            .font(.title)
                            .foregroundStyle(Color.white)
                    }
                }
                
                VStack{
                    AsyncImage(url: URL(string: pokemon.sprites.other?.home.frontDefault ?? "")) { photo in
                        photo
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 220, height:  220)
                            .cornerRadius(10)
                            .padding([.leading, . trailing], 32)
                            .opacity(0.8)
                        
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 220, height:  220)
                            .cornerRadius(10)
                            .padding([.leading, . trailing], 32)
                            .opacity(1)
                    }
                }
                
                VStack{
                    ScrollView {
                        VStack{
                            TextEditor(text: $text)
                                .padding()
                                .foregroundColor(Color.white)
                                .frame(maxWidth: 358, maxHeight: .infinity) // Usamos .infinity para permitir que el TextEditor crezca verticalmente
                                .frame(height: 180) // Ajusta el número de líneas que quieres mostrar
                                .scrollContentBackground(.hidden)
                            
                        }
                        .background(Color.clear)
                    }
                    Spacer()
                }
            }
            .padding(.top, 20)
            .onAppear {
                DispatchQueue.main.async {
                    Task {
                        let description = await rootViewModel.onSpeciesPokemon(species:pokemon.species.url)
                        for data in description.flavorTextEntries {
                            let currentLocale = Locale.current.language.languageCode?.identifier ?? "en"
                            let languageCode = currentLocale == "en" ? "en" : "es"
                            if data.language.name == languageCode{
                                text = text + data.flavorText
                            }
                        }
                    }
                }
            }
        }
    }
}




