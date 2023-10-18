//
//  ScoringInfoView.swift
//  TrapScores
//
//  Created by Doxie Davis on 4/7/22.
//

import SwiftUI

struct ScoringInfoView: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    var body: some View {
        
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    roundsData.selection = 0                }, label: {
                        Image(systemName: "x.circle")
                            .font(.title)
                    })
            }
            .padding(.trailing)
            Text("How To Use")
                .font(.title.italic())
                .fontWeight(.bold)
                .padding(.top)
            Text("v. 2.0")
                .font(.headline)
                .opacity(0.3)
            ScrollView {
                
                    Text("This app can be run on either an iPhone or an iPad.")
                        .fontWeight(.bold)
                HStack {
                    Text("General Operation of App:")
                        .underline()
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(3)
                Text("- Tap on the Range name at top of the Rounds or Graphs screen to switch between viewing each Range's prior rounds or graphed data. \n - Tap on New Round to start scoring on a new round. (See Scoring instructions below.)\n - Saved rounds can be edited by touching on the round in the Rounds view.  (Note: Press 'return' after editing a comment.)\n - Saved rounds can be deleted (permanently) by swiping to the left on the round in the Rounds view.")
                    .padding(3)
                HStack {
                    Text("Scoring:")
                        .underline()
                        .fontWeight(.bold)
                    Spacer()
                }
                Text("There are 3 ways to enter your scoring:")
                    .padding(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("1. Using the HIT or MISS buttons on the iPhone or iPad screen.\n2. Using a Bluetooth camera remote.\n3. Using an Apple Watch!\n")
                    .padding(.leading)
                HStack {
                    Text("1&2: Using on-screen HIT/MISS buttons or a Bluetooth camera remote:")
                        .fontWeight(.bold)
                    Spacer()
                }
                Text(" - App must be running and visible on screen during scoring.  Do not push lock/sleep button, go to home screen or switch to another app during or prior to scoring.\n - Once Range,Starting Position and Scoring Input method have been selected, scoring will start automatically at the starting position selected.  After 5 shots, scoring will move to the next position.  Scoring will stop when 25 rounds have been shot and will automatically go to the New Round Edit screen.\n - When using a Bluetooth remote, push either button once for a HIT and double-click for a MISS. (See example Bluetooth camera remotes below.)\n - Once you're on the New Round Edit screen, you can change Range selection, edit each position's Score if needed and add a Comment if desired.  Date and time are automatically entered and cannot be changed.")
                    .padding(3)
                HStack {
                    Text("3: Using an Apple Watch:")
                        .fontWeight(.bold)
                    Spacer()
                }
                Text(" - If you have an Apple Watch paired with your phone, the watch app should have been automatically installed on the watch.\n - The iPhone/iPad app does not need to be running.\n - Launch the TrapScores app in the watch.\n - Scroll up/down to select desired Range.\n - Then scroll to appropriate position to enter the Score for that position.\n - Tap on that Position to go to scoring screen.\n - Scroll to score for that position and tap on selected score.\n - Once scores for all positions have been entered, tap on Round Complete to enter a Comment and then Save Round.\n - Round will be saved to app on phone or iPad via the cloud.")
                    .padding(3)
                HStack {
                    Text("Example Bluetooth Camera Remotes:")
                        .fontWeight(.bold)
                    Spacer()
                }
                HStack {
                    Image("remote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 145)
                    Image("remote2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                }
                Text("\nSend me your comments & feedback:  myclayscores@gmail.com.  Enjoy!\n")
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
            }
            .padding(.leading)
            .padding(.trailing)
            .clipped()
        }
    }
}


struct ScoringInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScoringInfoView()
    }
}

