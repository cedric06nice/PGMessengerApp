//
//  PublicUsersManager.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 19/03/2021.
//

import SwiftUI

class PublicUsersManager: ObservableObject {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @Published var publicUser: [PublicUser] = []
    @Published var errorMessage: String = ""
    
    init() { }
    
    init(publicUser: [PublicUser]) {
        self.publicUser = publicUser
    }
    
    func findUsernameFromId(id: UUID) -> String {
        let username = self.publicUser.first(where: { $0.id == id })
        return username?.name ?? "unknownUser"
    }
}
