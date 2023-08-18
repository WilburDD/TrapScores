//
//  RangeSelectionView.swift
//  TrapScores
//
//  Created by Doxie Davis on 7/10/22.
//

import SwiftUI

struct RangeSelectionView: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    var body: some View {
        VStack {
            Text("Range?")
                .font(.title)
                .fontWeight(.bold)
                .italic()
            VStack {
                HStack {
                    Button(action: {
                        roundsData.selectedRange = "American Trap"
                        roundsData.contOpactity = 0.5
                        roundsData.intlOpacity = 0.5
                        roundsData.amerOpactity = 1.0
                    }, label: {
                        Text("American").font(.title)
                    })                            .font(.headline)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                        .opacity(roundsData.amerOpactity)
                    //                Spacer()
                    Button(action: {
                        roundsData.selectedRange = "Continental Trap"
                        roundsData.amerOpactity = 0.5
                        roundsData.intlOpacity = 0.5
                        roundsData.contOpactity = 1.0
                    }, label: {
                        Text("Continental").font(.title)
                    })
                    .font(.headline)
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                    .opacity(roundsData.contOpactity)
                    //                Spacer()
                }
                Button(action: {
                    roundsData.selectedRange = "ISSF/Olympic Trap"
                    roundsData.contOpactity = 0.5
                    roundsData.amerOpactity = 0.5
                    roundsData.intlOpacity = 1.0
                }, label: {
                    Text("ISSF/Olympic").font(.title)
                })
                .font(.headline)
                .padding(10)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .clipShape(Capsule())
                .opacity(roundsData.intlOpacity)
            }
        }
    }
}

struct RangeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RangeSelectionView()
            .environmentObject(RoundsDataStack())
    }
}
