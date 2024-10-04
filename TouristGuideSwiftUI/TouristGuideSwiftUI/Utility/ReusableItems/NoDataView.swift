//
//  NoDataView.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import SwiftUI

struct NoDataView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image("noDataFound")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
            
            Text("noResultsFound".localized)
                .font(.system(size: 16))
                .bold()
            Text("couldntFindStringMesssage".localized)
                .font(.system(size: 14))
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 2)
        )
    }
}

#Preview {
    NoDataView()
}
