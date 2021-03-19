//
//  PublicUser.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 12/03/2021.
//

import SwiftUI

struct PublicUser: Identifiable, Codable, Hashable {
    
    var id: UUID
    var name: String
    var createdAt: Date
}
