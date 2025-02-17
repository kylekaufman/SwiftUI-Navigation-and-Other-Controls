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
    var messages: [Message] = []
    
    mutating func addMessage(_ message: Message) {
        messages.append(message)
    }
}

struct MainScreen: View {
    @State private var contacts: [Contact] = []
    
    @State private var isAddingNewContact = false
    @State private var newContact = Contact(firstName: "", lastName: "", favorite: false)
    @State private var showSheet: Bool = false
    
    private func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
        ContactModel.save(contacts)
    }
    
    // Default contacts
    private var defaultContacts: [Contact] = [
        Contact(firstName: "John", lastName: "Doe", favorite: true),
        Contact(firstName: "Jane", lastName: "Smith", favorite: true),
        Contact(firstName: "Sam", lastName: "Brown", favorite: false)
    ]
    
    func addDefaultContactsIfNeeded() {
        // If contacts list is empty, load the default contacts and save them
        if contacts.isEmpty {
            contacts = defaultContacts
            ContactModel.save(contacts)
        }
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
                        showSheet = true
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
                            ContactModel.save(contacts) // Save after modification
                        })
                    }
                    .onDelete(perform: deleteContact)
                }
                .listStyle(PlainListStyle())
            }
            // Sheet for Profile View
            .sheet(isPresented: $showSheet, onDismiss: {
                ContactModel.save(contacts)
            }, content: {
                ProfileView(profile: $newContact, contacts: $contacts) { updatedContact in
                    contacts.append(updatedContact) // Add new contact when saved
                    showSheet = false // Dismiss the sheet
                }
            })
        }
        .onAppear {
            // Load the contacts from file
            contacts = ContactModel.load()
            
            // Ensure default contacts are added if file is empty
            addDefaultContactsIfNeeded()
        }
    }
}

#Preview {
    MainScreen()
}
