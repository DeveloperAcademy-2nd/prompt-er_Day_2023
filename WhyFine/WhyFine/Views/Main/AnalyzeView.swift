//
//  AnalyzeView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct AnalyzeView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var questionList: FetchedResults<Question>
    
    @ObservedObject var viewModel = ViewModel()
    
    @State private var isAnalyzed: Bool = false
    
    var body: some View {
        VStack {
            if !isAnalyzed {
                VStack {
                    Spacer()
                    
                    Button {
                        isAnalyzed.toggle()
                        viewModel.sendMessage()
                    } label: {
                        Text("아이 성향 분석하기")
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(16)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                }
                
            } else {
                if (viewModel.keyword != "") {
                    
                    ScrollView {
                        //                    if (viewModel.keyword != "") {
                        let pairs = extractKeywordsAndPercentages(from: viewModel.keyword)
                        
                        keywordRankViewer(rank: "1.", label: pairs[0].keyword, persentage: String(pairs[0].percent)+"%", medalBGColor: .yellow, meadalFGColor: .white)
                        keywordRankViewer(rank: "2.", label: pairs[1].keyword, persentage: String(pairs[1].percent)+"%", medalBGColor: .gray, meadalFGColor: .white)
                        keywordRankViewer(rank: "3.", label: pairs[2].keyword, persentage: String(pairs[2].percent)+"%", medalBGColor: .brown, meadalFGColor: .white)
                        
                        Text(viewModel.article)
                            .padding()
                            .background(Color(uiColor: .systemGray6))
                            .cornerRadius(16)
                    }
                }
            else {
                Spacer()
                
                Text("아이의 성향을 분석 중 입니다 ...")
                
                Spacer()
            }
        }
    }
        .padding()
        .onAppear {
            for question in questionList {
                viewModel.questionList += question.sentence ?? ""
                viewModel.questionList += "\n"
            }
        }
}

@ViewBuilder
private func keywordRankViewer(rank: String, label: String, persentage: String, medalBGColor: Color, meadalFGColor: Color) -> some View {
    HStack(alignment: .top) {
        Text(rank)
            .font(.system(size: 50))
            .fontWeight(.bold)
            .foregroundColor(meadalFGColor)
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
        
        Spacer()
        
        VStack(alignment: .trailing) {
            Text(label)
                .font(.system(size: 38))
                .fontWeight(.heavy)
                .foregroundColor(meadalFGColor)
            
            Text(persentage)
                .font(.system(size: 16))
                .foregroundColor(meadalFGColor)
        }
    }
    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
    .background(medalBGColor)
    .cornerRadius(16)
    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
}
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}

struct KeywordPercentPair: Identifiable {
    var id = UUID()
    var keyword: String
    var percent: Int
}

func extractKeywordsAndPercentages(from input: String) -> [KeywordPercentPair] {
    var pairs: [KeywordPercentPair] = []
    
    let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: ",")
    
    for line in lines {
        let components = line.components(separatedBy: "(")
        if components.count == 2 {
            let keyword = components[0].trimmingCharacters(in: .whitespaces)
            let percentString = components[1].trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "%)", with: "")
            
            if let percent = Int(percentString) {
                let pair = KeywordPercentPair(keyword: keyword, percent: percent)
                pairs.append(pair)
            }
        }
    }
    
    pairs = pairs.sorted(by: {$0.percent > $1.percent})
    
    return pairs
}

