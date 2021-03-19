//
//  MessageView.swift
//  PGMessengerApp
//
//  Created by cedric06nice on 17/03/2021.
//

import SwiftUI

struct MessageView: View {
    
    var username: String
    var timestamp: String
    var message: String
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Text(username)
                    .bold()
                Spacer()
                Text(timestamp)
                    .font(.caption2)
            }
            .padding(.vertical, 2)
            Text(message)
        }
        .padding(5)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(username: "user123",
                    timestamp: "12:34",
                    message: "A little message, which has been sent by user123 to the chat system, will appear here. 😎")
            .previewLayout(.sizeThatFits)
    }
}
