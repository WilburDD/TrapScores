//
//  GraphView.swift
//  TrapScores
//
//  Created by Doxie Davis on 9/7/22.
//

import SwiftUI
import CoreData

struct GraphView: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if roundsData.selectedRange == "American" {
                        roundsData.selectedRange = "Continental"
                        roundsData.contOpactity = 1.0
                        roundsData.amerOpactity = 0.5
                        roundsData.intlOpacity = 0.5
                    } else {
                        if roundsData.selectedRange == "Continental" {
                            roundsData.selectedRange = "Intl./Olympic"
                            roundsData.intlOpacity = 1.0
                            roundsData.contOpactity = 0.5
                            roundsData.amerOpactity = 0.5
                        } else {
                            if roundsData.selectedRange == "Intl./Olympic" {
                                roundsData.selectedRange = "American"
                                roundsData.intlOpacity = 0.5
                                roundsData.contOpactity = 0.5
                                roundsData.amerOpactity = 1.0
                            }}}
                    roundsData.fetchRounds()
                    roundsData.calcAvgs()
                }, label: {
                    Text("\(roundsData.selectedRange)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(2)
                })
                Spacer()
            }
            .padding(10)
            Spacer()
        Text("Graph View")
            Spacer()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
