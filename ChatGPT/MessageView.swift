//
//  MessageView.swift
//  ChatGPT
//
//  Created by Александра Маслова on 19.05.2023.
//

import SwiftUI

struct Bubble: View {
    private var message: Message
    init(message: Message) {self.message = message}
    
    var body: some View {
        HStack {
            if self.message.type == .user {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
            }
            if self.message.type == .gpt {
                Text(message.text)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                Spacer()
            }
        }.padding()
    }
}

