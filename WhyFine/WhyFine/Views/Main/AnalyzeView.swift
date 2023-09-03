//
//  AnalyzeView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct AnalyzeView: View {
    
    @State private var isAnalyzed: Bool = false
    @State private var article: String = """
    5세 아이의 질문들을 분석하면 다음과 같은 3가지 키워드가 도출됩니다:

    호기심(Curiosity): 이 아이는 다양한 주제에 대한 호기심이 높습니다. 하늘의 색, 구름의 형성, 동물 소리, 날씨 등 다양한 주제에 대해 궁금해하고 있습니다. 이러한 호기심은 새로운 정보를 탐색하려는 욕구를 나타냅니다.

    과학적 관심(Scientific Interest): 아이의 질문들은 과학과 관련된 주제에 대한 관심을 나타냅니다. 하늘의 색이나 구름의 형성과 같은 현상에 대한 과학적 원리를 이해하려는 노력을 보여줍니다.

    미래 고민(Future Exploration): 마지막 질문에서 "나중에 어른이 되면 무엇이 될까요?"라는 질문은 미래에 대한 고민과 상상력을 나타냅니다. 아이는 자신의 미래와 직업에 대한 생각을 하고 있으며, 성장과 역할에 대한 고민을 가지고 있습니다.

    이러한 세 가지 키워드를 통해 이 아이는 지적 호기심을 가진, 과학적인 관심을 가지고 있는 미래의 학습자로서의 특성을 보여줍니다.
    """
    @State private var extractedArticle: String = """
    호기심(60%)
    과학적 관심(20%)
    미래 고민(20%)
    """
    
    var body: some View {
        VStack {
            if !isAnalyzed {
                VStack {
                    Spacer()
                    
                    Button {
                        isAnalyzed.toggle()
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
                ScrollView {
                    
                    let pairs = extractKeywordsAndPercentages(from: extractedArticle)
                    
                    keywordRankViewer(rank: "1.", label: pairs[0].keyword, persentage: String(pairs[0].percent)+"%", medalBGColor: .yellow, meadalFGColor: .white)
                    keywordRankViewer(rank: "2.", label: pairs[1].keyword, persentage: String(pairs[1].percent)+"%", medalBGColor: .gray, meadalFGColor: .white)
                    keywordRankViewer(rank: "3.", label: pairs[2].keyword, persentage: String(pairs[2].percent)+"%", medalBGColor: .brown, meadalFGColor: .white)
                    
                    Text(article)
                        .padding()
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(16)
                    
                    
                }
            }
        }
        .padding()
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
    
    let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
    
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
    
    return pairs
}

