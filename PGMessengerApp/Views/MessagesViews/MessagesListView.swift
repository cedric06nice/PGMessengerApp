//
//  MessagesListView.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 12/03/2021.
//

import SwiftUI

struct MessagesListView: View {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @ObservedObject var userManager: UserManager
    @ObservedObject var publicUsersManager: PublicUsersManager
    @ObservedObject var messagesManager: MessagesManager

    var body: some View {
        VStack {
            List(messagesManager.messages, id:\.self) { message in
                MessageView(username: publicUsersManager.findUsernameFromId(id: message.owner.id),
                            timestamp: messagesManager
                                .formatedTimestamp(timestamp: message.timestamp),
                            message: message.subject)
            }
            Text("\(messagesManager.errorMessage)")
            Button("Logout") {
                userManager.logOut()
            }
        }
        .onAppear{
            MessagesController(messagesManager: messagesManager)
                .getAllMessages(token: token ?? "invalidToken")
            UserController(userManager: userManager,
                           publicUsersManager: publicUsersManager)
                .getAllUsers(token: token ?? "invalidToken")
        }
    }
}

struct MessagesListView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesListView(userManager: UserManager(),
                         publicUsersManager: PublicUsersManager(),
                         messagesManager: MessagesManager(
                            messages: [
                                Message(id: UUID(),
                                        timestamp: Date(),
                                        owner: Owner(id: UUID()),
                                        subject: "Message")]))
            .previewLayout(.sizeThatFits)
    }
}
