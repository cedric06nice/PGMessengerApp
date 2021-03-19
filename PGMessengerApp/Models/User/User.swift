//
//  User.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

struct User: Identifiable, Codable {
    
    var id: UUID
    var name: String
    var email: String
    var passwordHash: String
    var createdAt: Date
}
