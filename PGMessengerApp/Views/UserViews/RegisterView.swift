//
//  RegisterView.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 12/03/2021.
//

import SwiftUI

struct RegisterView: View {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @ObservedObject var userManager: UserManager
    @ObservedObject var publicUsersManager: PublicUsersManager
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordVerification: String = ""
    
    var body: some View {
        VStack {
            TextField("username", text: $username)
                .padding(.all)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .keyboardType(.default)
                .textCase(.lowercase)
                .accessibility(identifier: "Username")
            TextField("email@example.com", text: $email)
                .padding(.all)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .textCase(.lowercase)
                .accessibility(identifier: "Email")
            SecureField("password", text: $password)
                .padding(.all)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .accessibility(identifier: "Password")
            SecureField("password verification", text: $passwordVerification)
                .padding(.all)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .accessibility(identifier: "Password verification")
            Button(action: {
                    UserController(userManager: userManager,
                                   publicUsersManager: publicUsersManager)
                        .create(name: username,
                                email: email,
                                password: password,
                                passwordVerification: passwordVerification) },
                   label: {
                Text("Submit")
                    .padding()
            })
            .accessibility(identifier: "Submit button")
            Spacer()
            Text("\(userManager.errorMessage)")
                .foregroundColor(.red)
                .padding()
                .accessibility(identifier: "Error message")
            Text("\(userManager.token ?? "no token")")
                .foregroundColor(.red)
                .padding()
                .accessibility(identifier: "Token")
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(userManager: UserManager(), publicUsersManager: PublicUsersManager())
            .previewLayout(.sizeThatFits)
    }
}
