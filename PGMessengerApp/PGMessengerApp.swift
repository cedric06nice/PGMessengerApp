//
//  PGMessengerApp.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 11/03/2021.
//

import SwiftUI

@main
struct PGMessengerApp: App {
    
    @AppStorage(Constants.AppStorage.token) var token: String?

    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
