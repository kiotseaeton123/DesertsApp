//
//  ContentView.swift
//  Deserts
//
//  Created by zhongyuan liu on 5/1/23.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        
        TabView {
            
            HomeView().tabItem{Image(systemName: "house.fill")}
            SettingsView().tabItem{Image(systemName: "gearshape")}

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SettingsView: View{
    var body: some View{
        Text("settings")
    }
}
