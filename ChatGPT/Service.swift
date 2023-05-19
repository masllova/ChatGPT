//
//  Service.swift
//  ChatGPT
//
//  Created by Александра Маслова on 19.05.2023.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
    func send(message: String) -> AnyPublisher<ResponseBody, Error> {
        let body = MessageBody(model: Constants.model, prompt: message, temperature: 0.7, max_tokens: 1000)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.key)"
        ]
        
        return Future { [weak self] promise in
            guard self != nil else {return}
            AF.request(Constants.url, method: .post, parameters: body, encoder: .json, headers: headers)
                .responseDecodable(of: ResponseBody.self) { response in
                    switch response.result {
                    case .success(let result):
                        promise(.success(result))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}


