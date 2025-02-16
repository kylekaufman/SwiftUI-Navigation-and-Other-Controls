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
          Contact(firstName: "John", lastName: "Doe", favorite: true),
          Contact(firstName: "Jane", lastName: "Smith", favorite: true),
          Contact(firstName: "Sam", lastName: "Brown", favorite: false)
      ]
    
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
                        print("adding new contact")
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
        }
    }
}


#Preview {
    MainScreen()
}

