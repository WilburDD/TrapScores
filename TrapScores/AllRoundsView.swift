//
//  ContentView.swift
//  TrapScores
//
//  Created by Doxie Davis on 5/18/22.
//


import SwiftUI
import CoreData
import MediaPlayer

struct AllRoundsView: View {
    
    @StateObject var roundsData: RoundsDataStack = RoundsDataStack()
    
    var body: some View {
        
        NavigationView {
            VStack{
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
                    })
                    Spacer()
                    NavigationLink(destination: GetPositionView()) {
                        Text("New Round")
                            .font(.headline)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .clipShape(Capsule())
                    }
                    .onTapGesture {
                        roundsData.clearData()
                    }
                }
                .padding(10)
                Section(footer: RoundsFooter()) {
                    List {
                        ForEach(roundsData.roundsData, id: \.self) { item in
                            RoundsList(item: item)
                        }
                        .onDelete(perform: { indexSet in
                            roundsData.deleteRound(indexSet: indexSet)
                            roundsData.saveRounds()
                            roundsData.fetchRounds()
                            roundsData.calcAvgs()
                        })
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .environmentObject(roundsData)
    }
}

struct RoundsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRoundsView()
            .environment(\.managedObjectContext,
                          RoundsDataStack().managedObjectContext)
            .environmentObject(RoundsDataStack())
    }
}

