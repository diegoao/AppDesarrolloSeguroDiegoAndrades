//
//  PokemonRowView.swift
//  PracticaDesarrolloSeguroDiegoAndrades
//
//  Created by Macbook Pro on 21/5/24.
//

import SwiftUI


struct PokemonRowView: View {
    var pokemon: PokemonInfoModel
    @State private var text: String = ""


    var body: some View {
    
            ZStack(alignment: .topLeading ){
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 362, height: 480)
                    .cornerRadius(30)
                
                
                VStack{
                    VStack{
                        ZStack{
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(width:350, height: 35)
                                .cornerRadius(30)
                            Text("\(pokemon.species.name)")
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
                                    .foregroundColor(Color.gray)
                                    .frame(maxWidth: 358, maxHeight: .infinity) // Usamos .infinity para permitir que el TextEditor crezca verticalmente
                                    .frame(height: 110) // Ajusta el número de líneas que quieres mostrar
                                    .scrollContentBackground(.hidden)
                                
                            }
                            .background(Color.clear)
                        }
                        Spacer()
                        
                    }
                    
                }
                .padding(.top, 20)
            }
        }
}
/*
#Preview {
    PokemonRowView(pokemon: PokemonInfoModel(species: Species(name: "Pikachu", url: ""), sprites: Sprites(front_default: "", other: Other(dreamWorld: DreamWorld(frontDefault: "https://raw.githubusercontent//.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/25.svg"))) ))
//}
*/


