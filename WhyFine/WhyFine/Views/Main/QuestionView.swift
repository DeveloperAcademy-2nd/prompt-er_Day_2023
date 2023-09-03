//
//  QuestionView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct QuestionView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var questionList: FetchedResults<Question>
    
//    @State var questionList: Array<String> = []
    @ObservedObject var viewModel = ViewModel()
    
    @State private var selectedYear: Int = 2023
    @State var input = ""
    
    var body: some View {
        VStack {
            
            Picker("아이가 언제 태어났나요?", selection: $selectedYear) {
                ForEach(1990..<2024) { year in
                    Text(String(year) + "년생").tag(year)
                }
            }
            .padding(.bottom)
            
            ScrollView(.vertical) {
                ScrollViewReader { proxy in
                    ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                        messageView(message: message)
                    }
                    .onChange(of: viewModel.messages.filter({$0.role != .system}).count) { _ in
                        proxy.scrollTo(viewModel.messages.filter({$0.role != .system}).count - 1, anchor: .bottom)
                    }
                    .animation(.easeIn, value: viewModel.messages.filter({$0.role != .system}).count)
                }
            }
            
            Spacer()
            
            HStack {
                TextField("무엇이든 물어보세요!", text: $viewModel.currentInput, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    QuestionDataController()
                        .addQuestion(sentence: viewModel.currentInput, context: managedObjContext)
                    
                    viewModel.sendMessage()
                } label: {
                    Image(systemName: "paperplane.circle.fill")
                        .font(.system(size: 28))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .padding()
    }
}

@ViewBuilder
private func messageView(message: Message) -> some View {
    HStack {
        if message.role == .user {
            Spacer()
            
            Text(message.content)
                .padding()
                .background(Color(.black))
                .foregroundColor(Color(uiColor: .systemGray6))
                .fontWeight(.bold)
                .cornerRadius(16)
        }
        
        else if message.role == .assistant {
            Text(message.content)
                .padding()
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(16)
                .lineSpacing(5)
            
            Spacer()
        }
    }
    .padding(.bottom)
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
