//
//  QuestionView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

import SwiftUI

struct QuestionView: View {
    
    @State var askingQuestion: String = ""
    private var askedText: String = "왜 공장에서 연기가 나?"
    private var answeredText: String = "안녕, 친구야! 공장은 큰 건물이야. 거기에서는 다양한 일들을 하거나 물건을 만들어요. 그런데 때때로 공장 안에서 연기가 나와요. 연기는 물이나 물건을 더 뜨거워지게 하는 것 때문에 나와요. 그래서 공장 안에서 일할 때 뜨거운 것들이 있으면 연기가 나올 수 있어. 연기는 하늘로 올라가면서 사라져요. 중요한 건 연기는 우리 몸에 좋지 않아서 멀리 떨어져 있어야 해. 그리고 항상 안전하게 지내는 거야. 이해됐어, 친구야?"
    
    var body: some View {
        VStack {
            
            HStack {
                Spacer()
                    
                Text(askedText)
                    .padding()
                    .background(Color(.black))
                    .foregroundColor(Color(uiColor: .systemGray6))
                    .fontWeight(.bold)
                    .cornerRadius(16)
            }
            .padding(.bottom)
            
            HStack {
                Text(answeredText)
                    .padding()
                    .background(Color(uiColor: .systemGray6))
                    .cornerRadius(16)
                    .lineSpacing(5)
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                TextField("무엇이든 물어보세요!", text: $askingQuestion, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    
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

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
