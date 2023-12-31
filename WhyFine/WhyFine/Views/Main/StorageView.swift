//
//  StorageView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct StorageView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var questionList: FetchedResults<Question>
    
//    @State private var askedQuestionList: [String] = ["왜 공장에서 연기가 나?", "구름은 어떻게 만들어지나요?", "동물들이 어떻게 소리를 내나요?", "왜 비가 내릴까요?", "왜 나무는 무엇을 먹을까요?", "달은 어떻게 빛나나요?", "왜 날씨가 바뀌나요?", "바다 속에는 어떤 동물들이 살고 있나요?", "왜 꿈을 꾸게 될까요?", "나중에 어른이 되면 무엇이 될까요?"]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(questionList) { questionList in
                    Text(questionList.sentence ?? "최근 질문이 없습니다")
                }
                .onDelete(perform: deleteQuestion)
            }
            .navigationTitle("질문")
            .searchable(text: $searchText)
        }
    }
    
    private func deleteQuestion(offsets: IndexSet){
        withAnimation {
            offsets.forEach { index in
                let question = self.questionList[index]
                self.managedObjContext.delete(question)
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
