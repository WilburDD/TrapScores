//
//  RoundsList.swift
//  TrapScores
//
//  Created by Doxie Davis on 4/26/22.
//

import SwiftUI

struct RoundsList: View {
    
    let item: RoundEntity
    
    var body: some View {
        
        VStack {
            HStack {
                HStack {
                    Text("\(item.pos1)")
                    Spacer()
                }
                HStack {
                    Text("\(item.pos2)")
                    Spacer()
                }
                HStack {
                    Text("\(item.pos3)")
                    Spacer()
                }
                HStack {
                    Text("\(item.pos4)")
                    Spacer()
                }
                HStack {
                    Text("\(item.pos5)")
                    Spacer()
                }
                Text("\(item.total)")
                    .fontWeight(.bold)
            }
            .font(.title)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                alignment: .leading)
            HStack {
                Text("\(item.date! .formatDate())")
                Spacer()
                Text("\(item.comment!)")
            }
            .font(.caption.italic())
            
        }
    }
}

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("d MMM yyyy, HH:mm")
        return dateFormatter.string(from: self)
    }
}

//struct RoundsList_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundsList(item: RoundEntity())
//    }
//}
