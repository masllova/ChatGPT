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
        if list.isEmpty {
            VStack {
                Spacer()
                Text(
"""
Hello!
I am your personal assistant, based on the ChatGPT 3.5 language model from OpenAI.

How can I help you?
""")
                .padding()
                .font(.title2)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
            }
        }
        ScrollView {
            LazyVStack {
                ForEach(list, id: \.self) {message in
                    Bubble(message: message)
                }
            }.rotationEffect(.degrees(180))
        }.rotationEffect(.degrees(180))
        .padding(.top)
        
        .onTapGesture {hideKeyboard()}
        Divider()
        HStack {
            TextEditor(text: $input)
                .frame(height: 35)
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Text(" Enter...")
                            .foregroundColor(.gray)
                            .opacity(input.isEmpty ? 1 : 0)
                            .padding(.horizontal, 3)
                        Spacer()
                    }
                )
                .shadow(radius: 3)
            if list.count % 2 == 0 {
                Button {
                    if !input.isEmpty {send()}
                } label: {
                    Image(systemName: "paperplane")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .shadow(radius: 5)
                }
            }
        }.padding()
    }
    func send() {
        let userMessage = Message(id: UUID().uuidString, type: .user, text: input, dateCreated: Date())
        list.append(userMessage)
        service.send(message: input).sink { completion in
            print("error")
        } receiveValue: { response in
            guard let firstChoice = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            let gptMessage = Message(id: UUID().uuidString, type: .gpt, text: firstChoice, dateCreated: Date())
            list.append(gptMessage)
        }
        .store(in: &cancellable)
        input = ""
        hideKeyboard()
    }
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
        
    }
}
