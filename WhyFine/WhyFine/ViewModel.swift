//
//  ViewModel.swift
//  WhyFine
//
//  Created by 차차 on 2023/09/02.
//
import Foundation

extension QuestionView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        
        @Published var currentInput: String = ""
        
        private let openAIAPI = OpenAIAPI()
        
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput) // TODO: .system 으로 아이에게 설명하도록 설정 (only in GPT4)
            messages.append(newMessage)
            currentInput = ""
            
            Task {
                let response = await openAIAPI.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id:UUID(), role:receivedOpenAIMessage.role, content: receivedOpenAIMessage.content)
                await MainActor.run {
                    messages.append(receivedMessage)
                }
            }
        }
    }
}
