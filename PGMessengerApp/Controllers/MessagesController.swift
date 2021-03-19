//
//  MessagesController.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

class MessagesController {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @ObservedObject var messagesManager: MessagesManager

    init(messagesManager: MessagesManager) {
        self.messagesManager = messagesManager
    }
    
    func getAllMessages(token: String) {
        self.messagesManager.errorMessage = ""
        ApiController.getAllMessages(token: self.token ?? "") { (result) in
            switch result {
                case .success(let success):
                    DispatchQueue.main.async {
                        self.messagesManager.errorMessage = ""
                        self.messagesManager.messages = success
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.messagesManager.errorMessage = ServerError.noData.localizedDescription
                    }
            }
        }
    }
    
    // MARK: TODO: Implement function to call for posting a new message on the chat
    func postNewMessage(token: String, message: String) { }
}
