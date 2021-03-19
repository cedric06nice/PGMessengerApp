//
//  MessagesManager.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 18/03/2021.
//

import SwiftUI

class MessagesManager: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var errorMessage: String = ""
    
    init() { }
    
    init(messages: [Message]) {
        self.messages = messages
    }
    
    func formatedTimestamp(timestamp: Date) -> String {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTimeStamp = calendar.startOfDay(for: timestamp)
        let components = calendar.dateComponents([.day], from: startOfTimeStamp, to: startOfToday)
        guard let interval = components.day else { return "Invalid date" }
        if interval == 0 {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.timeStyle = .short
            formatter.doesRelativeDateFormatting = true
            return formatter.string(from: timestamp)
        }
        else {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            formatter.doesRelativeDateFormatting = true
            return formatter.string(from: timestamp)
        }
    }
}
