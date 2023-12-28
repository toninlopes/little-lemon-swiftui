//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 28/12/23.
//

import SwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) var presentation
    let firstName = UserDefaults.standard.string(forKey: K_FIRSTNAME)
    let lastName = UserDefaults.standard.string(forKey: K_LASTNAME)
    let email = UserDefaults.standard.string(forKey: K_EMAIL)

    var body: some View {
        VStack {
            Text("Personal information")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Image("profile-image-placeholder")
            Text(firstName ?? "First Name")
            Text(lastName ?? "Last Name")
            Text(email ?? "email@email.com")
            Spacer()
            Button("Logout", action: {
                UserDefaults.standard.setValue(false, forKey: K_ISLOGGEDIN)
                self.presentation.wrappedValue.dismiss()
            })
        }
        .padding(.all, 12)
    }
}

#Preview {
    UserProfile()
}
