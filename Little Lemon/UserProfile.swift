//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Antonio Lopes on 28/12/23.
//

import SwiftUI

struct Notification: Identifiable {
    let id: String
    let label: String
    let systemImage: String
    var isSubscribed: Bool = false
    
    init(id: String, label: String, systemImage: String) {
        self.id = id
        self.label = label
        self.systemImage = systemImage
        self.isSubscribed = UserDefaults.standard.bool(forKey: id)
    }
    
    mutating func restore() -> Void {
        self.isSubscribed = UserDefaults.standard.bool(forKey: id)
    }
}

struct UserProfile: View {
//    @Environment(\.presentationMode) var presentation
    @Binding var path: NavigationPath
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var notifications: Array<Notification> = []

    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Personal information")
                        .font(.title)
                    HStack() {
                        VStack(alignment: .leading) {
                            Image("profile-image-placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle()
                                    .stroke(Color(.littleLemonGreen), lineWidth: 4))
                                .shadow(radius: 2)
                        }
                        
                        Button("Change", action: {})
                            .buttonStyle(LLGreenButtonDisabled())
                        Button("Remove", action: {})
                            .buttonStyle(LLLightButtonDisabled())
                    }
                    .padding(.bottom)
                    
                    TextField("First Name", text: $firstName)
                        .padding(.bottom)
                    
                    TextField("Last Name", text: $lastName)
                        .padding(.bottom)
                    
                    TextField("Email", text: $email)
                        .padding(.bottom)
                    
                    TextField("Phone Number", text: $phoneNumber)
                        .padding(.bottom)
                        .keyboardType(.phonePad)
                    
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                VStack(alignment: .leading) {
                    Text("Email notification")
                        .font(.title)
                    
                    ForEach($notifications) { $notification in
                        Toggle(isOn: $notification.isSubscribed) {
                            Label(notification.label, systemImage: notification.systemImage)
                        }
                        .padding(.bottom)
                    }
                }
                .padding([.top, .bottom])
                
                Spacer()
                
                Button("Log out", action: onLogout)
                    .buttonStyle(LLYellowButton())
                
                HStack() {
                    Button("Discard Changes", action: onDiscardChanges)
                        .buttonStyle(LLLightButton())
                    Button("Save Changes", action: onSaveChanges)
                        .buttonStyle(LLGreenButton())
                }
                .padding(.top, 24)
            }
            .padding(12)
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image(.littleLemonBanner)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 4)
            }
        }
        .padding(.bottom, 22)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {
            print(path)
            self.onDiscardChanges()
        })
    }
}

extension UserProfile {
    func onLogout() -> Void {
        UserDefaults.standard.setValue(false, forKey: K_ISLOGGEDIN)
        path = NavigationPath()
    }
    
    func onDiscardChanges() -> Void {
        firstName = (UserDefaults.standard.string(forKey: K_FIRSTNAME) ?? "")
        lastName = (UserDefaults.standard.string(forKey: K_LASTNAME) ?? "")
        email = (UserDefaults.standard.string(forKey: K_EMAIL) ?? "")
        phoneNumber = (UserDefaults.standard.string(forKey: K_PHONENUMBER) ?? "")
        
        notifications = [
            Notification(id: K_ORDER, label: "Order Statuses", systemImage: "cart"),
            Notification(id: K_PASSWORD, label: "Password Changes", systemImage: "ellipsis.rectangle"),
            Notification(id: K_OFFERS, label: "Special Offers", systemImage: "gift"),
            Notification(id: K_NEWSLETTER, label: "Newsletter", systemImage: "newspaper")
        ]
    }
    
    func onSaveChanges() -> Void {
        UserDefaults.standard.setValue(firstName, forKey: K_FIRSTNAME)
        UserDefaults.standard.setValue(lastName, forKey: K_LASTNAME)
        UserDefaults.standard.setValue(email, forKey: K_EMAIL)
        UserDefaults.standard.setValue(phoneNumber, forKey: K_PHONENUMBER)
        
        for item in notifications {
            UserDefaults.standard.setValue(item.isSubscribed, forKey: item.id)
        }
    }
}

//#Preview {
//    NavigationStack {
//        UserProfile()
//    }
//}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        @State var path: NavigationPath = .init()
        
        NavigationStack {
            UserProfile(path: $path)
        }
    }
}
