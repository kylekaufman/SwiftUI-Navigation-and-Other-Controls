//
//  ContactRow.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Emmanuel Makoye on 2/16/25.
//

import SwiftUI

struct ContactRow: View {
    @Binding var contact: Contact
    @Binding var contacts: [Contact]
    var onSave: (Contact) -> Void  // Add onSave closure
    @State var isFavorive: Bool = true
    
    var body: some View {
        HStack {
            // Profile Image
            if let imageName = contact.profileImageName, !imageName.isEmpty {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }

            // Contact Details
            VStack(alignment: .leading) {
                Text(contact.firstName)
                    .font(.headline)
                Text(contact.lastName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            if isFavorive, contact.favorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.black)
                    .font(.title2)
            }
                
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle()) // Makes tapping work properly
        .background(
            NavigationLink(
                "",
                destination: MessageScreen(contact: $contact, contacts:$contacts, onSave: onSave)
            )
            .opacity(0) // Invisible NavigationLink
        )
    }
}
struct ContactRowPreview: View {
    @State private var contact = Contact(firstName: "Emmanuel", lastName: "Makoye", favorite: true)
    @State private var contacts: [Contact] = []

    var body: some View {
        ContactRow(contact: $contact, contacts: $contacts, onSave: { updatedContact in
            contact = updatedContact // Ensure state updates in preview
        }, isFavorive: true)
    }
}

#Preview {
    ContactRowPreview()
}

