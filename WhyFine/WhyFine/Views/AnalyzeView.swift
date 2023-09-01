//
//  AnalyzeView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct AnalyzeView: View {
    var body: some View {
        Button {
            
        } label: {
            Text("아이 성향 분석하기")
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(16)
                .fontWeight(.bold)
        }

    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
