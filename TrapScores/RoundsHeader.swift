//
//  RoundsFooter.swift
//  TrapScores
//
//  Created by Doxie Davis on 4/26/22.
//

import SwiftUI

struct RoundsHeader: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    var body:  some View{
        VStack {
            HStack {
                Text("Averages")
                Spacer()
                Text("Rounds: \(roundsData.totalRnds)")
            }
            .font(.title2)
            HStack {
                HStack {
                    Text("\(roundsData.pos1Avg, specifier: "%.1f")")
                    Spacer()
                    Text("\(roundsData.pos2Avg, specifier: "%.1f")")
                    Spacer()
                    Text("\(roundsData.pos3Avg, specifier: "%.1f")")
                    Spacer()
                    Text("\(roundsData.pos4Avg, specifier: "%.1f")")
                    Spacer()
                    Text("\(roundsData.pos5Avg, specifier: "%.1f")")
                    Spacer()
                }
                Text("\(roundsData.totalAvg, specifier: "%.1f")")
                    .fontWeight(.bold)
            }
            .font(.title2.italic())
            .padding(.bottom, 0)
        }
        .padding(.leading)
        .padding(.trailing)
        CustomDivider()
        .environmentObject(roundsData)
    }
}

struct CustomDivider: View {
    let color: Color
    let height: CGFloat
    
    init(color: Color = .blue.opacity(1.0),
         height: CGFloat = 2.0) {
        self.color = color
        self.height = height
    }
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
            .edgesIgnoringSafeArea(.horizontal)
        
    }
}

struct RoundsFooter_Previews: PreviewProvider {
    static var previews: some View {
        RoundsHeader()
    }
}
