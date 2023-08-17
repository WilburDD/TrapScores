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
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    if roundsData.selectedRange == "American Trap" {
                        roundsData.selectedRange = "Continental Trap"
                        roundsData.contOpactity = 1.0
                        roundsData.amerOpactity = 0.5
                        roundsData.intlOpacity = 0.5
                    } else {
                        if roundsData.selectedRange == "Continental Trap" {
                            roundsData.selectedRange = "Intl./Olympic Trap"
                            roundsData.intlOpacity = 1.0
                            roundsData.contOpactity = 0.5
                            roundsData.amerOpactity = 0.5
                        } else {
                            if roundsData.selectedRange == "Intl./Olympic Trap" {
                                roundsData.selectedRange = "American Trap"
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
            Section(header: RoundsHeader()) {
                List {
                    ForEach(roundsData.roundsData, id: \.self) { item in
                        NavigationLink {
                            SavedRoundEdit(item: item)
                        } label: {
                            RoundsList(item: item)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        roundsData.deleteRound(indexSet: indexSet)
                        roundsData.saveRounds()
                        roundsData.fetchRounds()
                        roundsData.calcAvgs()
                    })
                }
                .listStyle(.plain)
            }
            .onAppear{
                roundsData.fetchRounds()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
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

