//
//  Home.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 26/12/23.
//

import SwiftUI

struct Home: View {
    @Binding var path: NavigationPath
    let persistenceController = PersistenceController.shared
    
    var body: some View {
        TabView {
            Menu(path: $path)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem { Label("Menu", systemImage: "list.dash") }
            UserProfile(path: $path)
                .tabItem { Label("Profile", systemImage: "square.and.pencil") }
            
        }.navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    Home()
//}
