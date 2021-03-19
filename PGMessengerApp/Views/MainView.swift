//
//  MainView.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @StateObject var userManager = UserManager()
    @StateObject var publicUsersManager = PublicUsersManager()
    @StateObject var messagesManager = MessagesManager()
    @State var selection = 1

    var body: some View {
        VStack {
            if token != "" {
                MessagesListView(userManager: userManager,
                                 publicUsersManager: publicUsersManager,
                                 messagesManager: messagesManager)
            }
            else {
                TabView(selection: $selection) {
                    LoginView(userManager: userManager,
                              publicUsersManager: publicUsersManager)
                        .tabItem {
                            VStack {
                                Image(systemName: "lock")
                                Text("Login")
                            }
                        }.tag(1)
                    RegisterView(userManager: userManager,
                                 publicUsersManager: publicUsersManager)
                        .tabItem {
                            VStack {
                                Image(systemName: "pencil")
                                Text("Register")
                            }
                        }.tag(2)
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
