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
    @State private var contacts: [Contact] = []
    
    @State private var isAddingNewContact = false
    @State private var newContact = Contact(firstName: "", lastName: "", favorite: false)
    
    private func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
        ContactModel.save(contacts)
    }

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
                        ContactRow(contact: $contacts[index], contacts: $contacts, onSave: { updatedContact in
                            contacts[index] = updatedContact
                        })
                    } .onDelete(perform: deleteContact)
                }
                .listStyle(PlainListStyle())
            }
            .navigationDestination(isPresented: $isAddingNewContact) {
                ProfileView(profile: $newContact, contacts: $contacts) { updatedContact in
                    contacts.append(updatedContact) // Add new contact when saved
                    isAddingNewContact = false // Dismiss the screen
                }
            }
        }.onAppear {
            contacts =  ContactModel.load()
        }
    }
}

#Preview {
    MainScreen()
}
