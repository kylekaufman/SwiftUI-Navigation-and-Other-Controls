//
//  ProfileScreen.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Emmanuel Makoye on 2/16/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profile: Contact
    @Binding var contacts: [Contact]
    var onSave: (Contact) -> Void
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Profile Image
                if let imageName = profile.profileImageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top, 40)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                }
                
                // Editable Fields
                VStack(spacing: 20) {
                    HStack{
                        TextField("First Name", text: $profile.firstName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    HStack{
                        TextField("Last Name", text: $profile.lastName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                    }
                    HStack(alignment: .center) {
                        Toggle(isOn: $profile.favorite) {
                            EmptyView() // No label here
                        }
                        .labelsHidden() // Hide the default label of the toggle
                        
                        Text("Is Favorite")
                            .padding()
                            .padding(.horizontal)
                    }
                }
                Spacer()
            }
            .onDisappear{
                saveProfile()
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("First Name and Last Name cannot be empty."), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func saveProfile() {
        if profile.firstName.isEmpty || profile.lastName.isEmpty {
            showingAlert = true
        } else {
            onSave(profile) // Call the onSave closure to save the contact
            ContactModel.save(contacts)
        }
    }
}

// Preview with Editable Profile
struct ProfilePreview: View {
    @State private var userProfile = Contact(firstName: "Emmanuel", lastName: "Makoye", favorite: true)
    @State private var contacts = [Contact]()

    var body: some View {
        ProfileView(profile: $userProfile, contacts: $contacts) { updatedProfile in
            print("Profile Updated: \(updatedProfile.firstName) \(updatedProfile.lastName), Favorite: \(updatedProfile.favorite)")
        }
    }
}

#Preview {
    ProfilePreview()
}
