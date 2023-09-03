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
        @Published var age: Int = 5
        
        private let openAIAPI = OpenAIAPI()
        
        func sendMessage() {
            messages.append(Message(id: UUID(), role: .system, content: "\(age)살 아이에게 설명한다고 생각하고 모든 질문에 답하시오."))
            let newMessage = Message(id: UUID(), role: .user, content: currentInput)
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

extension AnalyzeView {
    class ViewModel: ObservableObject {
        @Published var messages: [Message] = []
        @Published var questionList: String = ""
        @Published var article: String = ""
        @Published var keyword: String = ""
        
        let prompt1 = "위와 같은 질문을 한 5세 아이의 관심분야를 3개의 대표 키워드로 나타내고 각 키워드를 설명해줘"
        let prompt2 = "위와 같은 질문을 한 5세 아이의 관심분야를 [관심분야(퍼센트),관심분야(퍼센트),관심분야(퍼센트)] 형식에 맞춰 3개 골라줘. 형식 이외의 답변은 제외해줘"
        private let openAIAPI = OpenAIAPI()
        
        func sendMessage() {
            let newMessage1 = Message(id: UUID(), role: .user, content: questionList + prompt1)
            messages.append(newMessage1)
            let newMessage2 = Message(id: UUID(), role: .user, content: questionList + prompt2)
            messages.append(newMessage2)
            
            Task {
                let response = await openAIAPI.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id:UUID(), role:receivedOpenAIMessage.role, content: receivedOpenAIMessage.content)
                await MainActor.run {
                    messages.append(receivedMessage)
                    
                    var sidx = receivedMessage.content.firstIndex(of:"[")
                    var eidx = receivedMessage.content.lastIndex(of:"]")
                    
                    if sidx != nil && eidx != nil {
                        sidx = receivedMessage.content.index(after: sidx!)
                        
                        keyword = String(receivedMessage.content[sidx! ..< eidx!])
                    }
                    
                    article = receivedMessage.content.replacingOccurrences(of: "[" + keyword + "]",  with: "")
                }
            }
        }
    }
}
