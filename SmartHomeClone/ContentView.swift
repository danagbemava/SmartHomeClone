//
//  ContentView.swift
//  SmartHomeClone
//
//  Created by Daniel Agbemava on 20/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                HomeView()
                    .tabItem{
                        Label(title: {
                            Text("")
                        }, icon: {
                            Image(systemName: "house")
                        })
                    }
                Text("")
                    .tabItem{
                        Label(title: {
                            Text("")
                        }, icon: {
                            Image(systemName: "house")
                        })
                    }
                Text("")
                    .tabItem{
                        Label(title: {
                            Text("")
                        }, icon: {
                            Image(systemName: "house")
                        })
                    }
                Text("")
                    .tabItem{
                        Label(title: {
                            Text("")
                        }, icon: {
                            Image(systemName: "house")
                        })
                    }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
