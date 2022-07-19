//
//  ScoringInfoView.swift
//  TrapScores
//
//  Created by Doxie Davis on 4/7/22.
//

import SwiftUI

struct ScoringInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Scoring Info").font(.largeTitle).fontWeight(.bold)
                Spacer()
                Button(action: {dismiss()},
                       label: {
                    Image(systemName: "x.circle").font(.largeTitle)
                })
            }
            .padding(.top)
            Spacer()
            Text("Scoring will start automatically at the starting position selected.  After 5 shots, scoring will move to the next position.  Scoring will stop when 25 rounds have been shot.\n\nThere are two ways to enter your HIT or MISS score after each shot:")
                .fontWeight(.bold)
                .padding(2)
            //                .padding(5)
            Text("1. Tap either the HIT or MISS button on the iPhone screen, or Volume-Up Button/HIT, Volume-Down/MISS.")
                .padding(5)
            Text("2. Use a bluetooth camera shutter remote (example shown). Click large button/HIT and small button/MISS.")
                .padding(5)
            Spacer()
            Image("remote")
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            Spacer()
        }
        .navigationBarHidden(true)
        .font(.system(size: 18))
        .multilineTextAlignment(.leading)
        .padding(.leading)
        .padding(.trailing)
    }
}

struct ScoringInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScoringInfoView()
    }
}
