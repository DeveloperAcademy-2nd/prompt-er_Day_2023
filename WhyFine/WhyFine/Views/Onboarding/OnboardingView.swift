//
//  OnboardingView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var selectedYear: Int = 2023
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("아이가 언제 태어났나요?")
            Picker("아이가 언제 태어났나요?", selection: $selectedYear) {
                ForEach(1990..<2024) { year in
                    Text(String(year) + "년생").tag(year)
                }
            }
            .pickerStyle(.wheel)
            
            Spacer()
            
            NavigationLink {
                MainView()
            } label: {
                Text(String(selectedYear)+"년생 맞아요!")
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(16)
                    .fontWeight(.bold)
            }
        }
        .padding()
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
