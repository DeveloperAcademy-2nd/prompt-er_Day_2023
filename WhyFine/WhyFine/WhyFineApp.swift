//
//  WhyFineApp.swift
//  WhyFine
//
//  Created by 차차 on 2023/09/01.
//

import SwiftUI

 @main
struct WhyFineApp: App {
    @StateObject private var questionDataController = QuestionDataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, questionDataController.container.viewContext)
                
        }
    }
}
