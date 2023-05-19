//
//  ContentView.swift
//  ChatGPT
//
//  Created by Александра Маслова on 19.05.2023.
//

import SwiftUI
import Combine

struct ChatView: View {
    @State private var list: [Message] = []
    @State private var input = ""
    
    @State private var cancellable = Set<AnyCancellable>()
    
    let service = OpenAIService()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(list, id: \.self) {message in
                    Bubble(message: message)
                }
            }
        }
        HStack {
            TextField("Enter...", text: $input, onCommit: {send()})
            Button {
                send()
            } label: {
                Image(systemName: "paperplane")
                    .font(.title2)
                    .foregroundColor(.green)
                    .shadow(radius: 5)
            }

        }.padding()
    }
    func send() {
        let userMessage = Message(id: UUID().uuidString, type: .user, text: input, dateCreated: Date())
        list.append(userMessage)
        service.send(message: input).sink { completion in
            //error
        } receiveValue: { response in
            guard let firstChoice = response.choices.first?.text else {return}
            let gptMessage = Message(id: UUID().uuidString, type: .gpt, text: firstChoice, dateCreated: Date())
            list.append(gptMessage)
        }
        .store(in: &cancellable)
        input = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
