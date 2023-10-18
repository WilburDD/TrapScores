//
//  Pos1View.swift
//  MCS Watch App
//
//  Created by Doxie Davis on 9/5/23.
//

import SwiftUI

struct ScoringView: View {
    
    @EnvironmentObject var roundData: WatchData
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert: Bool = false
    
    var item: Int
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if roundData.roundTotal == 0 {
                        roundData.clearData()
                        dismiss()
                    } else {
                        showAlert = true
                    }
                }, label: {
                    Text("<")
                        .font(.title2)
                        .foregroundColor(.white)
                })
                .frame(width: 40, height: 25)
                .alert("WARNING", isPresented: $showAlert) {
                    Button("DISCARD", role: .destructive) {
                        roundData.clearData()
                        dismiss()
                    }
                    Button("Continue Scoring", role: .cancel) {
                        showAlert = false
                    }
                } message: {
                    Text("Exiting without saving round will discard any scoring input.")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            
            VStack {
                Text("\(roundData.range)")
                    .fontWeight(.bold)
                    .underline()
                Text("Total Score: \(roundData.roundTotal)")
            }
            .font(.title3)
            List {
                ForEach (0...roundData.positions, id: \.self) { item in
                    NavigationLink {
                        EnterScore(item: item)
                    } label: {
                        HStack {
                            Spacer()
                            VStack (alignment: .leading) {
                                Text("Pos \(item + 1)")
                                Spacer()
                                Text("Score: ")
                            }
                            .font(.title3)
                            Spacer()
                            Text("\(roundData.posCount[item])")
                                .font(.title2)
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                }
            }
            HStack {
                NavigationLink(destination: FinishRound(),
                               label: {
                    Text("Round Complete")
                })
                .foregroundColor(.white)
                .frame(width: 170, height: 40)
                .background(.teal, in: Capsule())
                
            }
            .padding()
        }
        .listStyle(CarouselListStyle())
        .ignoresSafeArea(edges: .top)
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)
        //        Spacer()
        .environmentObject(roundData)
        .onAppear {
            roundData.range = roundData.ranges[item]
            roundData.pos = item + 1
            roundData.positions = 4
            roundData.scoring = [5, 5, 5, 5, 5]
        }
    }
}


struct ScoringView_Previews: PreviewProvider {
    static var previews: some View {
        ScoringView(item: 1)
            .environmentObject(WatchData())
    }
}
