//
//  ContentView.swift
//  TrapScores
//
//  Created by Doxie Davis on 2/27/22.
//

import SwiftUI
import CoreData
import MediaPlayer
import AVFoundation

struct NewRoundView: View {
    
    let rounds: [RoundEntity]
    
    @EnvironmentObject var roundsData: RoundsDataStack
    @State private var showAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack{
            HStack {
                Button(action: {
                    if roundsData.shotCount == 0 {
                        roundsData.clearData()
                        roundsData.turnOffClicker()
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }, label: {
                    Image(systemName: "arrow.left").font(.title2)
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text("WARNING"),
                        message: Text("Exiting before scoring is complete will discard all of this round's data."),
                        primaryButton: .cancel(Text("Continue Round")),
                        secondaryButton: .destructive(Text("Discard Data"), action: {
                            roundsData.clearData()
                            roundsData.turnOffClicker()
                            dismiss()
                        }))
                })
                Spacer()
                Text("\(roundsData.selectedRange)").font(.title).fontWeight(.bold)
                Spacer()
                NavigationLink(destination: ScoringInfoView()) {
                    Image(systemName: "questionmark.circle").font(.title)
                }
            }
            
            ProgressView("", value: Double(roundsData.shotCount), total: 25).accentColor(.black)
            
            HStack {
                VStack{
                    Text ("\(roundsData.posCount[0])")
                        .font(.largeTitle)
                        .underline()
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .opacity(roundsData.seePos[0])
                    Text("\(roundsData.pos1Avg, specifier: "%.1f")").italic()
                }
                Spacer()
                VStack{
                    Text ("\(roundsData.posCount[1])")
                        .font(.largeTitle)
                        .underline()
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .opacity(roundsData.seePos[1])
                    Text("\(roundsData.pos2Avg, specifier: "%.1f")").italic()
                }
                Spacer()
                VStack{
                    Text ("\(roundsData.posCount[2])")
                        .font(.largeTitle)
                        .underline()
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .opacity(roundsData.seePos[2])
                    Text("\(roundsData.pos3Avg, specifier: "%.1f")").italic()
                }
                Spacer()
                VStack{
                    Text ("\(roundsData.posCount[3])")
                        .font(.largeTitle)
                        .underline()
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .opacity(roundsData.seePos[3])
                    Text("\(roundsData.pos4Avg, specifier: "%.1f")").italic()
                }
                Spacer()
                VStack{
                    Text ("\(roundsData.posCount[4])")
                        .font(.largeTitle)
                        .underline()
                        .fontWeight(.bold)
                        .padding(.bottom)
                        .opacity(roundsData.seePos[4])
                    Text("\(roundsData.pos5Avg, specifier: "%.1f")").italic()
                }
            }
            .padding([.leading, .bottom, .trailing, .top])
            Spacer()
            HStack{
                Spacer()
                VStack{
                    Text("Shots").font(.largeTitle).fontWeight(.bold)
                    Text("\(roundsData.shotCount)").font(.largeTitle).fontWeight(.bold)
                }
                Spacer()
                VStack{
                    Text("Hits").font(.largeTitle).fontWeight(.bold)
                    Text("\(roundsData.roundTotal)").font(.largeTitle).fontWeight(.bold)
                }
                Spacer()
                VStack{
                    Text("Average").font(.largeTitle).fontWeight(.bold).italic()
                    Text ("\(roundsData.totalAvg, specifier: "%.1f")").font(.largeTitle).italic().fontWeight(.bold)
                }
                Spacer()
            }
            Spacer()
            Image("TrapShooter")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top)
            Spacer()
            if roundsData.phoneScoring == true {
                ScoringButtonsView()
                Spacer()
            } else {
                EmptyView()
            }
        }
        .multilineTextAlignment(.center)
        .navigationBarHidden(true)
        
        NavigationLink(
            destination: EditView(),
            isActive: $roundsData.roundComplete,
            label: {})
        
        .environmentObject(roundsData)
        .onAppear{
            roundsData.scoringStarted = true
            MPVolumeView.setVolume()
            roundsData.observeClicker()
        }
        .onChange(of: roundsData.resetVolume) { newValue in
            MPVolumeView.setVolume()
        }
    }
}


struct NewRoundView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoundView(rounds: [])
            .environmentObject(RoundsDataStack())
    }
}

