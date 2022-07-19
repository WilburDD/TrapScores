//
//  RoundsFooter.swift
//  TrapScores
//
//  Created by Doxie Davis on 4/26/22.
//

import SwiftUI

struct RoundsFooter: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    var body:  some View{
        VStack {
            Divider()
            HStack {
                HStack {
                    Text("\(roundsData.pos1Avg, specifier: "%.1f")")
                    Spacer()
                }
                HStack {
                    Text("\(roundsData.pos2Avg, specifier: "%.1f")")
                    Spacer()
                }
                HStack {
                    Text("\(roundsData.pos3Avg, specifier: "%.1f")")
                    Spacer()
                }
                HStack {
                    Text("\(roundsData.pos4Avg, specifier: "%.1f")")
                    Spacer()
                }
                HStack {
                    Text("\(roundsData.pos5Avg, specifier: "%.1f")")
                    Spacer()
                }
                Text("\(roundsData.totalAvg, specifier: "%.1f")")
                    .fontWeight(.bold)
            }
            .font(.title2.italic())
            .padding(.leading)
            .padding(.trailing)
            HStack {
                Text("Running Averages").font(.headline.italic())
                Spacer()
                Text("Total rounds: \(roundsData.totalRnds)").font(.title2)
            }
            .padding(.leading)
            .padding(.trailing)
        }
        .environmentObject(roundsData)
    }
}

struct RoundsFooter_Previews: PreviewProvider {
    static var previews: some View {
        RoundsFooter()
    }
}
