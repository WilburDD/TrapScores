//
//  TrapScoresWatchApp.swift
//  TrapScoresWatch Watch App
//
//  Created by Doxie Davis on 10/12/23.
//

import SwiftUI

@main
struct TrapScores_Watch_App: App {
    
    @StateObject var roundData = WatchData()

    var body: some Scene {
        WindowGroup {
            ChooseRange()
                .environmentObject(roundData)
                .environment(\.managedObjectContext,
                              roundData.managedObjectContext)
        }
    }
}
