
import SwiftUI

let Destination = {
    let menu: String = "Menu"
    let userProfile: String = "UserProfile"
}

struct Onboarding: View {
    let persistenceController = PersistenceController.shared
    @State var path: NavigationPath = .init()
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var isLoading = true
    
    var body: some View {
        NavigationStack(path: $path.animation(.easeInOut)) {
            VStack {
                if isLoading {
                    ProgressView() {
                        Text("Loading")
                            .font(.title2)
                    }
                    .controlSize(.large)
                } else {
                    LLHero()
                    
                    VStack(alignment: .leading) {
                        TextField("First Name", text: $firstName)
                            .padding(.bottom)
                        
                        TextField("Last Name", text: $lastName)
                            .padding(.bottom)
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .padding(.bottom)
                        
                        Spacer()
                        
                        Button("Register", action: onRegister)
                            .buttonStyle(LLGreenButton())
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.all)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(.littleLemonBanner)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.bottom, 4)
                }
            }
            .tint(.littleLemonGreen)
            .accentColor(.littleLemonGreen)
            .navigationDestination(for: String.self) { dest in
                if (dest == "Menu") {
                    Menu(path: $path).environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
                if (dest == "UserProfile") {
                    UserProfile(path: $path)
                }
            }
            .task {
                onScreenLoad()
            }
        }
    }
}

extension Onboarding {
    private func onScreenLoad() -> Void {
        if UserDefaults.standard.bool(forKey: K_ISLOGGEDIN) {
            path.append("Menu")
        }
        firstName = ""
        lastName = ""
        email = ""
        isLoading = false
    }
    
    private func onRegister() -> Void {
        if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
            return
        }

        UserDefaults.standard.setValue(firstName, forKey: K_FIRSTNAME)
        UserDefaults.standard.setValue(lastName, forKey: K_LASTNAME)
        UserDefaults.standard.setValue(email, forKey: K_EMAIL)
        UserDefaults.standard.setValue(true, forKey: K_ISLOGGEDIN)
        
        path.append("Menu")
    }
}


#Preview {
    Onboarding()
}
