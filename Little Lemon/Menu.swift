//
//  Menu.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 26/12/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Little Lemon")
                .font(.title)
            Text("Chicago")
                .font(.title2)
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with modern twist.")
            List {
                
            }
        }
        .padding(.all, 12)
    }
}

#Preview {
    Menu()
}
