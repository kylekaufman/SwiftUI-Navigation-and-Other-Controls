//
//  ContactRow.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Emmanuel Makoye on 2/16/25.
//

import SwiftUI

struct ContactRow: View {
    @Binding var contact: Contact
    var onSave: (Contact) -> Void  // Add onSave closure
    
    var body: some View {
        HStack {
            // Profile Image
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)

            // Contact Details
            VStack(alignment: .leading) {
                Text(contact.firstName)
                    .font(.headline)
                Text(contact.lastName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
                Image(systemName: contact.favorite ? "star.fill" : "star")
                    .foregroundColor(contact.favorite ? .black : .gray)
                    .font(.title2)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle()) // Makes tapping work properly
        .background(
            NavigationLink(
                "",
                destination: MessageScreen(contact: $contact, onSave: onSave)
            )
            .opacity(0) // Invisible NavigationLink
        )
    }
}
struct ContactRowPreview: View {
    @State private var contact = Contact(firstName: "Emmanuel", lastName: "Makoye", favorite: false)

    var body: some View {
        ContactRow(contact: $contact, onSave: { updatedContact in
            contact = updatedContact // Ensure state updates in preview
        })
    }
}

#Preview {
    ContactRowPreview()
}

