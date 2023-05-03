//
//  ContentView.swift
//  Deserts
//
//  Created by zhongyuan liu on 5/1/23.
//
/*
 ContentView consists of tabView for HomeView and SettingsView
 MARK: HomeView contains technical interview requirements
 TODO: SettingsView for implementation of user preferences
 */

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        //        MARK: tech interview material inside HomeView
        TabView {
            //            homeView shows sorted list of deserts
            HomeView().tabItem{Image(systemName: "house.fill")}
            //            settingsview will be for user preferences
            SettingsView().tabItem{Image(systemName: "gearshape")}
            
        }
    }
}

//TODO: User Preferences & Settings with UserDefaults/<plist>
struct SettingsView: View{
    var body: some View{
        List{
            Text("user settings 1")
            Text("user settings 2")
            Text("user settings 3")
            Text("user settings 4")
            Text("user settings 5")

        }
    }
}
