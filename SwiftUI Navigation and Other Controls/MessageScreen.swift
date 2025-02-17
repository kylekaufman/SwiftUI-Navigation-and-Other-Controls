
//  ContentView.swift
//  Intro to Swift UI
//
//  Created by Kyle Kaufman and Emmanuel Makoye on 1/23/25.
//

import SwiftUI

struct Message: Identifiable {
    var id: UUID
    var message: String
    var date: Date

    init(message: String) {
        self.id = UUID()
        self.message = message
        self.date = Date()
    }
}

struct MessageView: View {
    var message: Message
    // Date formatter function
    
    func getDateFormat(_ date: Date) -> String {
        // Create a DateFormatter instance
        let dateFormatter = DateFormatter()
        
        //apply styling
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        // Return the formatted date string
        return dateFormatter.string(from: date)
    }
      
    
    var body: some View {
           VStack(alignment: .trailing) {
               // Message text
               Section {
                   Text(message.message)
                       .padding(10)
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(15)
                       .frame(maxWidth: .infinity, alignment: .trailing)
                       .padding(.leading, 50)
                       .padding(.horizontal)
                       .padding(.vertical, 5)
               }

               // Date and Time
               Section {
                   Text(getDateFormat(message.date))
                       .font(.footnote)
                       .foregroundColor(.gray)
                       .padding(.top, 2)
                       .padding(.trailing, 15)
               }
           }
       }
   }

struct MessageScreen: View {
    @State var messages = [Message]()
    @State var message = ""
    @Binding var contact: Contact
    @Binding var contacts: [Contact]
    @State private var navigateToProfile = false  // State variable to trigger navigation
    var onSave: (Contact) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    navigateToProfile = true  // Set navigation trigger to true
                }) {
                    HStack(spacing: 15) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                            .padding(8)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(contact.firstName) \(contact.lastName)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .buttonStyle(PlainButtonStyle())

                Divider()
                
                ScrollView {
                    ForEach(messages) { msg in
                        MessageView(message: msg)
                    }
                    .padding(.vertical, 5)
                }
                
                HStack {
                    TextField("Message", text: $message)
                    Button(action: {
                        messages.append(Message(message: message))
                        message = ""
                    }) {
                        Image(systemName: "paperplane")
                    }
                }
            }
            .padding()
            .navigationDestination(isPresented: $navigateToProfile) {
                ProfileView(profile: $contact, contacts: $contacts, onSave: onSave)
            }
        }
    }
}
struct   MessageScreenPreview: View {
    @State private var contact = Contact(firstName: "Emmanuel", lastName: "Makoye", favorite: false)
    @State private var contacts: [Contact] = []

    var body: some View {
        MessageScreen(messages: [], message: "", contact: $contact, contacts: $contacts, onSave: { updatedContact in
            contact = updatedContact // Ensure state updates in preview
        })
    }
}


#Preview {
    MessageScreenPreview()
}
