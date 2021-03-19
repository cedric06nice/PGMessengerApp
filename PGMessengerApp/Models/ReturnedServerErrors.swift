//
//  ReturnedServerErrors.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 15/03/2021.
//

import SwiftUI

struct ReturnedServerErrors: Identifiable, Codable {
    
    var id: UUID?
    var error: Bool
    var reason: String
}
