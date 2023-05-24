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
                    .textSelection(.enabled)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
            if self.message.type == .gpt {
                Text(message.text)
                    .textSelection(.enabled)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                Spacer()
            }
        }.padding(.horizontal, 10)
    }
}

