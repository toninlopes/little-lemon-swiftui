
import SwiftUI

struct Onboarding: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: Home(),
                    isActive: $isLoggedIn,
                    label: {
                        EmptyView()
                    })
                TextField("First Name", text: $firstName)
                
                TextField("Last Name", text: $lastName)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                Button("Register", action: {
                    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
                        return
                    }
                    
                    UserDefaults.standard.setValue(firstName, forKey: K_FIRSTNAME)
                    UserDefaults.standard.setValue(lastName, forKey: K_LASTNAME)
                    UserDefaults.standard.setValue(email, forKey: K_EMAIL)
                    UserDefaults.standard.setValue(true, forKey: K_ISLOGGEDIN)
                    isLoggedIn = true
                })
            }.padding(.all, 12)
                .onAppear(perform: {
                    if UserDefaults.standard.bool(forKey: K_ISLOGGEDIN) {
                        isLoggedIn = true
                    }
                })
        }
    }
}

#Preview {
    Onboarding()
}
