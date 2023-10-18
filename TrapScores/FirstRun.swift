//
//  FirstRun.swift
//  TrapScores
//
//  Created by Doxie Davis on 10/15/23.
//

import SwiftUI

struct FirstRun: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    @Environment(\.dismiss) var dismiss
    
    @AppStorage ("firstRun") var firstRun = true
    
    var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "x.circle")
                            .font(.title)
                    })
                }
                Text("Welcome to\nTrapScores v. 2.0")
                    .font(.title.italic())
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text("\nThere are now 3 ways to enter your scores:")
                Text("1. Using the HIT or MISS button on the iPhone or iPad screen.\n2. Using a Bluetooh camera remote.\n3. Using an Apple Watch!")
                    .padding()
                Text("Scoring with the Apple Watch is independent of the app and the app doesn't need to be running on your phone or iPad.  Scores are added to the app from the watch via the cloud.\n\nSee ''? Info'', for complete instructions.\n\nSend me your comments & feedback:  myclayscores@gmail.com.  Enjoy!\n")
                    .multilineTextAlignment(.center)
            }
            .fontWeight(.bold)
            .padding(.leading)
            .padding(.trailing)
//            Button(action: {
//                firstRun = false
//                roundsData.selection = 0
//            }, label: {
//                Text("Don't show me this again.")
//                    .font(.headline)
//                    .padding()
//            })
//            .background(Color.teal)
//            .foregroundColor(Color.white)
//            .clipShape(Capsule())
    }
}


#Preview {
    FirstRun()
}
