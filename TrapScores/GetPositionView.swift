//
//  GetPositionView.swift
//  TrapScores
//
//  Created by Doxie Davis on 3/28/22.
//

import SwiftUI
import MediaPlayer
import AVFoundation

struct GetPositionView: View {
    
    @EnvironmentObject var roundsData: RoundsDataStack
    
    var body: some View {
        
        VStack{
            Spacer().frame(height: 50)
            Text("Range?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .italic()
            RangeSelectionView()
            ZStack {
                Image("range")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(0.2)
                VStack{
                    Text ("Position?").font(.largeTitle).fontWeight(.bold).italic()
                    HStack {
                        Button(action: {
                            roundsData.setData(pos: 0)
                        }, label: {
                            Text("1").font(.title)
                        })
                        .getPosButtonStyle()
                        .opacity(roundsData.seePos[0])
                        Spacer()
                        Button(action: {
                            roundsData.setData(pos: 1)
                        }, label: {
                            Text("2").font(.title)
                        })
                        .getPosButtonStyle()
                        .opacity(roundsData.seePos[1])
                        Spacer()
                        Button(action: {
                            roundsData.setData(pos: 2)
                        }, label: {
                            Text("3").font(.title)
                        })
                        .getPosButtonStyle()
                        .opacity(roundsData.seePos[2])
                        Spacer()
                        Button(action: {
                            roundsData.setData(pos: 3)
                        }, label: {
                            Text("4").font(.title)
                        })
                        .getPosButtonStyle()
                        .opacity(roundsData.seePos[3])
                        Spacer()
                        Button(action: {
                            roundsData.setData(pos: 4)
                        }, label: {
                            Text("5").font(.title)
                        })
                        .getPosButtonStyle()
                        .opacity(roundsData.seePos[4])
                    }
                    .padding()
                }
            }
            Divider()
                .frame(height: 3)
                .frame(width: 300)
                .overlay(.blue)
            Spacer()
            ScoringSelectionView()
                .padding()
            Spacer()
            Text("Press clicker or iPhone volume button AFTER selecting Range & Position to start scoring.")
                .fontWeight(.bold)
                .italic()
                .multilineTextAlignment(.center)
                .font(.title2)
            //            Spacer()
            NavigationLink(
                destination: NewRoundView(rounds: Array(roundsData.roundsData)),
                isActive: $roundsData.posSelected,
                label: {})
            .environmentObject(roundsData)
            .onAppear{
                roundsData.seePos = [0.3, 0.3, 0.3, 0.3, 0.3]
                roundsData.clickerConfirm = true
                roundsData.turnOnClicker()
                MPVolumeView.setVolume()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

extension MPVolumeView {
    static func setVolume() -> Void {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = 0.5
        }
    }
}

extension Button {
    func getPosButtonStyle() -> some View {
        self
            .frame(width: 50, height: 50)
            .foregroundColor(.black)
            .background(Color(.green))
            .clipShape(Circle())
    }
}

struct GetPositionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GetPositionView()
                .environmentObject(RoundsDataStack())
            GetPositionView()
                .environmentObject(RoundsDataStack())
        }
    }
}
