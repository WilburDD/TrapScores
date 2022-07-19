//
//  TrapScoresApp.swift
//  TrapScores
//
//  Created by Doxie Davis on 3/1/22.
//

import SwiftUI

@main
struct TrapScoresApp: App {
    
    private let roundsDataStack = RoundsDataStack()
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        
        WindowGroup {
            AllRoundsView()
                .environment(\.managedObjectContext,
                              roundsDataStack.managedObjectContext)
                .environmentObject(roundsDataStack)
                .onChange(of: scenePhase) { _ in
                    roundsDataStack.saveRounds()
                }
        }
    }
}
