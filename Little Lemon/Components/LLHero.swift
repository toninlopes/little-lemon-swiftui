//
//  Hero.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 18/01/24.
//

import SwiftUI

struct LLHero: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.largeTitle)
                .foregroundColor(Color(.littleLemonYellow))
            HStack {
                VStack(alignment: .leading) {
                    Text("Chicago")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom)
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with modern twist.")
                        .foregroundColor(.white)
                }
                Image(.heroRestaurant)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .frame(width: 140)
            }
            .padding(.top, -12)
            
        }
        .padding(.all, 12)
        .background(Color(.littleLemonGreen))
    }
}

struct SearchTextField: ViewModifier {
    @Binding var searchText: String
    @State private var isEditing = false
    
    func body(content: Content) -> some View {
        VStack {
            
            content
    
            VStack {
                TextField("Search", text: $searchText)
                    .padding(8)
                    .padding(.horizontal, 26)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onTapGesture {
                        self.isEditing = true
                    }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom)
             
                    if isEditing {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 20)
                                .padding(.bottom)
                        }
                    }
                }
            )
            
        }
        .background(Color(.littleLemonGreen))
    }
}

extension LLHero {
    func withSearchTextField(searchText: Binding<String>) -> some View {
        modifier(SearchTextField(searchText: searchText))
    }
}

#Preview {
    LLHero()
        .withSearchTextField(searchText: .constant(""))
}
