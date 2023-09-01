//
//  MainView.swift
//  WhyFine
//
//  Created by 박상준 on 2023/09/01.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            QuestionView()
                .tabItem {
                    Image(systemName: "message")
                }
            
            StorageView()
                .tabItem {
                    Image(systemName: "tray.full.fill")
                }
            
            AnalyzeView()
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
