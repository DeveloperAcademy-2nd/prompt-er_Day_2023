//
//  OpenAIAPI.swift
//  WhyFine
//
//  Created by 차차 on 2023/09/03.
//

import Foundation
import Alamofire

class OpenAIAPI {
    private let endpointUrl = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async -> OpenAIChatResponse? {
        let openAIMessages = messages.map({OpenAIChatMessage(role: $0.role , content: $0.content)})
        
        let body = OpenAIChatBody(model: "gpt-4", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(ApiKey.openAIApiKey)"
        ]
        return try? await AF.request(endpointUrl, method: .post, parameters: body, encoder: .json, headers: headers).serializingDecodable(OpenAIChatResponse.self).value
    }
}

