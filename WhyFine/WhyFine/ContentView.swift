//
//  ContentView.swift
//  WhyFine
//
//  Created by 차차 on 2023/09/01.
//

import SwiftUI

struct ContentView: View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
