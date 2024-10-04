//
//  StatisticsDataSheetView.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import SwiftUI

struct StatisticsDataSheetView: View {
    let data: (Int, [[Character: Int]])
    var buttonClicked: () -> Void

    var body: some View {
        ZStack {
            Color("cellBackground").opacity(0.7)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Spacer()
                    Button {
                        buttonClicked()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .tint(.black)
                    }
                }
                Text("statisticsTitleString".localized)
                    .font(.system(size: 18))
                    .bold()

                Text("Total list items: \(data.0)")
                    .bold()
                
                ForEach(data.1.indices, id: \.self) { index in
                    let dict = data.1[index]
                    if let (key, value) = dict.first {
                        HStack {
                            Text("-> \(key): \(value)")
                                .font(.headline)
                        }
                        .padding(.horizontal ,10)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    StatisticsDataSheetView(data: (3, [["A": 5], ["B": 3], ["C": 2]])) {

    }
}
