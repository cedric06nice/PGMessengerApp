//
//  Session.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 12/03/2021.
//

import SwiftUI

struct Session: Identifiable, Codable {
    
    var id: UUID?
    var token: String
    var user: UserSession
}

struct UserSession: Identifiable, Codable {
    
    var id: UUID
    var name: String
    var createdAt: Date
}
