//
//  TrapScoresApp.swift
//  TrapScores
//
//  Created by Doxie Davis on 3/1/22.
//

import SwiftUI

@main
struct TrapScoresApp: App {
    
    @StateObject var roundsDataStack = RoundsDataStack()
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        
        WindowGroup {
//            if #available(iOS 16.0, *) {
//                NavigationStack {
//                    OpeningTabView()
//                }
//            } else {
//                // Fallback on earlier versions
//                NavigationView {
//                    OpeningTabView()
//                }
//            }
            
            //            TabView {
                        OpeningTabView()
            //                    .tabItem{
            //                        Image(systemName: "list.bullet")
            //                    }
            //                GetPositionView()
            //                    .tabItem{
            //                        Image(systemName: "plus.square.fill")
            //                    }
            //                GraphView()
            //                    .tabItem{
            //                        Image(systemName: "chart.xyaxis.line")
            //                    }
            //                ScoringInfoView()
            //                    .tabItem{
            //                        Image(systemName: "questionmark.circle")
            //                    }
            //            }
            //            .accentColor(.blue)

                .environmentObject(roundsDataStack)
                .environment(\.managedObjectContext,
                              roundsDataStack.managedObjectContext)
                .onChange(of: scenePhase) { _ in
                    roundsDataStack.saveRounds()
                }
        }
    }
}

