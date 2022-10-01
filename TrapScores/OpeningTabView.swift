//
//  OpeningView.swift
//  TrapScores
//
//  Created by Doxie Davis on 9/6/22.
//

import SwiftUI
import CoreData

struct OpeningTabView: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    //    @StateObject var roundsData: RoundsDataStack = RoundsDataStack()
    
    var body: some View {
        //        NavigationView {
        if #available(iOS 16.0, *) {
            NavigationStack {
                TabView {
                    AllRoundsView()
                        .tabItem{
                            Image(systemName: "list.bullet")
                        }
                    GraphView()
                        .tabItem{
                            Image(systemName: "chart.xyaxis.line")
                        }
                    GetPositionView()
                        .tabItem{
                            Image(systemName: "plus.square.fill")
                        }
                    ScoringInfoView()
                        .tabItem{
                            Image(systemName: "questionmark.circle")
                        }
                }
                .accentColor(.blue)
            }
        } else {
            // Fallback on earlier versions
            NavigationView {
                TabView {
                    AllRoundsView()
                        .tabItem{
                            Image(systemName: "list.bullet")
                        }
                    GraphView()
                        .tabItem{
                            Image(systemName: "chart.xyaxis.line")
                        }
                    GetPositionView()
                        .tabItem{
                            Image(systemName: "plus.square.fill")
                        }
                    ScoringInfoView()
                        .tabItem{
                            Image(systemName: "questionmark.circle")
                        }
                }
                .accentColor(.blue)
            }
        }
    }
}

struct OpeningTabView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningTabView()
    }
}
