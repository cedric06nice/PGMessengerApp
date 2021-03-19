//
//  UserManager.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 15/03/2021.
//

import SwiftUI

class UserManager: ObservableObject {
    
    @AppStorage(Constants.AppStorage.token) var token: String?
    @Published var user: UserSession? = nil
    @Published var errorMessage: String = ""
    
    init() { }
    
    init(token: String, user: UserSession) {
        self.token = token
        self.user = user
    }
    
    var isLoggedIn: Bool { self.token != nil }
    
    func logOut() {
        self.user = nil
        self.token = ""
    }
}
