//
//  ProfileScreen.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Emmanuel Makoye on 2/16/25.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profile: Contact
    var onSave: (Contact) -> Void
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Profile Image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.gray)
                    .padding(.top, 40)
                
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
                
                // Save Button
                Button(action: {
                    saveProfile()
                }) {
                    Text("Save")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                Spacer()
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
        }
    }
}

// Preview with Editable Profile
struct ProfilePreview: View {
    @State private var userProfile = Contact(firstName: "Emmanuel", lastName: "Makoye", favorite: true)

    var body: some View {
        ProfileView(profile: $userProfile) { updatedProfile in
            print("Profile Updated: \(updatedProfile.firstName) \(updatedProfile.lastName), Favorite: \(updatedProfile.favorite)")
        }
    }
}

#Preview {
    ProfilePreview()
}
