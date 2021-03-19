//
//  LoginView.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 15/03/2021.
//

import SwiftUI

struct LoginView: View {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @ObservedObject var userManager: UserManager
    @ObservedObject var publicUsersManager: PublicUsersManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var error: String = ""
    
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
            SecureField("password", text: $password)
                .padding(.all)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.center)
                .accessibility(identifier: "Password")
            Button(action: {
                    UserController(userManager: userManager,
                                   publicUsersManager: publicUsersManager)
                        .login(name: username, password: password) },
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
            Text("\(token ?? "no token")")
                .foregroundColor(.red)
                .padding()
                .accessibility(identifier: "Token")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userManager: UserManager(), publicUsersManager: PublicUsersManager())
            .previewLayout(.sizeThatFits)
    }
}
