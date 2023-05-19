//
//  Objects.swift
//  ChatGPT
//
//  Created by Александра Маслова on 19.05.2023.
//

import Foundation

struct MessageBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
}

struct ResponseBody: Decodable {
    let id: String
    let choices: [ResponseChoices]
}

struct ResponseChoices: Decodable {
    let text: String
}

struct Message: Hashable {
    let id: String
    let type: Sender
    let text: String
    let dateCreated: Date
}

public enum Sender {
    case user
    case gpt
}

enum Constants {
    static let key = "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"
    static let url = "https://api.openai.com/v1/completions"
    static let model = "text-davinci-003"
}
