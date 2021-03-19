//
//  Message.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

struct Message: Identifiable, Codable, Hashable {
    
    var id: UUID
    var timestamp: Date
    var owner: Owner
    var subject: String
}

struct Owner: Identifiable, Codable, Hashable {
    
    var id: UUID
}
