//
//  TouristSpotCellView.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import SwiftUI

struct TouristSpotCellView: View {
    let touristSpot: TouristSpot
    var body: some View {
        HStack {
            Image(touristSpot.image)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .cornerRadius(10)
                .padding(12)

            VStack(alignment: .leading) {
                Text(touristSpot.name)
                    .lineLimit(1)
                    .font(.system(size: 17))
                    .bold()

                Text(touristSpot.description)
                    .lineLimit(2)
                    .font(.system(size: 14))
            }
            
            Spacer()
        }
        .background(Color.cellBackground)
        .frame(maxWidth: .infinity)
        .cornerRadius(10)
    }
}

#Preview {
    TouristSpotCellView(touristSpot: TouristSpot(name: "Eiffel Tower", location: "Paris", description: "A wrought-iron lattice tower built by Gustave Eiffel for the 1889 Exposition Universelle.", image: "eiffelTower"))
}
