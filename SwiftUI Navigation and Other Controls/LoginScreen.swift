import SwiftUI

struct LoginScreen: View {
    @State var username = ""
    @State var password = ""
    @Binding var isLoggedIn:Bool
    @State var loginFailed = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Sign In")
                    .font(.system(size: 50))
                    .padding(.bottom, 40)
                
                HStack {
                    TextField("Enter username", text: $username)
                        .padding()
                        .border(Color.black, width: 2)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                }
                .padding(.bottom, 10)
                HStack {
                    SecureField("Enter password", text: $password)
                        .padding()
                        .border(Color.black, width: 2)
                        .padding(.horizontal, 20)
                        .autocapitalization(.none)
                }
                .padding(.bottom, 30)
                Button(action: {
                    if username == "spartie" && password == "messages" {
                        isLoggedIn = true
                        loginFailed = false
                    }
                    else {
                        loginFailed = true
                    }
                }) {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .font(.system(size: 24, weight: .bold))
                        .padding()
                        .frame(width: 150, height: 40)
                        .background(Color.blue)
                }
                if loginFailed {
                    Text("Incorrect username or password")
                        .foregroundColor(.red)
                        .font(.body)
                        .padding(.top, 10)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    LoginScreen(isLoggedIn: .constant(false))
}
