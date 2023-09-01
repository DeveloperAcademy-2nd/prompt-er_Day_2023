//
//  RecordView.swift
//  WhyFine
//
//  Created by Youngbin Choi on 2023/09/01.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var questionList: FetchedResults<Question>
    
    @State var questionSentence: String
    
    var body: some View {
        Form {
            TextField("질문을 입력하세요", text: $questionSentence)
            Button {
                QuestionDataController()
                    .addQuestion(sentence: questionSentence, context: managedObjContext)
                questionSentence = ""
                
            } label: {
                Rectangle()
                    .cornerRadius(10)
            }
            ForEach(questionList) { questionList in
                Text(questionList.sentence ?? "최근 질문이 없습니다")
            }
            .onDelete(perform: deleteQuestion)
            
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



struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(questionSentence: "")
    }
}
