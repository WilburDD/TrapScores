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
            OpeningTabView()
                .environmentObject(roundsDataStack)
                .environment(\.managedObjectContext,
                              roundsDataStack.managedObjectContext)
                .onChange(of: scenePhase) { _ in
                    roundsDataStack.saveRounds()
                }
        }
    }
}

