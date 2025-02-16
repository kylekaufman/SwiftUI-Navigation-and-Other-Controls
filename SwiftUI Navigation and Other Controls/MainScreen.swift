//
//  MainScreen.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Kyle Kaufman on 2/7/25.
//

import SwiftUI

struct Contact: Identifiable, Hashable, Codable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var favorite: Bool
}

struct MainScreen: View {
    @State private var contacts: [Contact] = [
        Contact(firstName: "Emmanuel", lastName: "Makoye", favorite: true),
        Contact(firstName: "Jane", lastName: "Smith", favorite: true),
        Contact(firstName: "Sam", lastName: "Brown", favorite: false)
    ]
    
    @State private var isAddingNewContact = false
    @State private var newContact = Contact(firstName: "", lastName: "", favorite: false)

    var body: some View {
        NavigationStack {
            VStack {
                // Header with Title and Add Button
                HStack {
                    Text("Contacts")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button(action: {
                        newContact = Contact(firstName: "", lastName: "", favorite: false) // Reset new contact
                        isAddingNewContact = true
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                // Contacts List
                List {
                    ForEach(contacts.indices, id: \.self) { index in
                        ContactRow(contact: $contacts[index], onSave: { updatedContact in
                            contacts[index] = updatedContact
                        })
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationDestination(isPresented: $isAddingNewContact) {
                ProfileView(profile: $newContact) { updatedContact in
                    contacts.append(updatedContact) // Add new contact when saved
                    isAddingNewContact = false // Dismiss the screen
                }
            }
        }
    }
}

#Preview {
    MainScreen()
}
