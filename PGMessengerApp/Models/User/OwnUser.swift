//
//  OwnUser.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 19/03/2021.
//

import SwiftUI

struct OwnUser: Identifiable, Codable, Hashable {
    
    var id: UUID
    var name: String
    var email: String
    var createdAt: Date
}
