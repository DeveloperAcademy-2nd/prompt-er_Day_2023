//
//  AnalyzeView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct AnalyzeView: View {
    
    @State var isAnalyzed: Bool = false
    @State var report: String = """
    이 아이의 질문들은 자연과 과학, 환경, 인간 행동, 그리고 미래에 대한 다양한 주제에 대한 호기심을 나타내며, 교육적인 관심과 탐구 정신을 보여줍니다. 이러한 질문들을 종합적으로 분석하면, 아이는 지적 탐구와 관찰력을 향상하고, 자신의 주변 세계와 연결하며 이해하기를 원하는 학습자로 보입니다.

    첫째로, "왜 하늘은 파랗게 보일까?"라는 질문을 통해 아이는 빛과 색에 대한 과학적 원리를 이해하고자 합니다. 이 질문은 과학적 지식을 개발하고 더 깊은 이해를 추구하는 데 도움이 될 것입니다.

    둘째로, "구름은 어떻게 만들어지나요?"라는 질문은 기상 현상과 환경에 대한 호기심을 보여줍니다. 아이는 구름의 형성과 기상 상황 사이의 관계를 이해하고자 하며, 이를 통해 환경에 대한 이해력을 향상시킬 것입니다.

    셋째로, "동물들이 어떻게 소리를 내나요?"라는 질문은 동물 행동과 소리에 대한 궁금증을 나타냅니다. 아이는 동물의 의사소통 방법과 소리의 원리를 탐구하며 동물과 인간의 상호작용에 대한 이해를 확장하려고 합니다.

    넷째로, "왜 비가 내릴까요?"라는 질문은 날씨와 기후 현상에 대한 호기심을 나타냅니다. 아이는 강우의 원리와 기상 패턴에 대한 더 많은 지식을 획득하고자 합니다.

    다섯째로, "왜 나무는 무엇을 먹을까요?"라는 질문은 자연 생태계와 생물학에 대한 관심을 보여줍니다. 아이는 나무와 식물의 영양 흡수 과정과 생태학적 역할을 이해하고자 합니다.

    이 아이의 호기심과 질문들은 교육적으로 유용한 발판이며, 과학적 탐구와 환경에 대한 관심을 촉진하는데 도움이 될 것입니다.
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
                    Text(report)
                        .padding()
                        .background(Color(uiColor: .systemGray6))
                        .cornerRadius(16)
                        .lineSpacing(5)
                }
            }
        }
        .padding()
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
