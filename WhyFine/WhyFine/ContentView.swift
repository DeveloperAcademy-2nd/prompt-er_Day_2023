//
//  ContentView.swift
//  WhyFine
//
//  Created by 차차 on 2023/09/01.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        NavigationView {
            if isFirstLaunching == true {
                OnboardingView()
            } else {
                MainView()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

public func checkIfFirstInApp() {
    UserDefaults.standard.set(false, forKey: "firstInApp")
}

