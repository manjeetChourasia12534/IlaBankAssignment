//
//  CountryImageCarouselView.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import SwiftUI

struct CountryImageCarouselView: View {
    @Binding var countryList: [Country]
    @Binding var selectedIndex: Int

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(countryList.indices, id: \.self) { index in
                Image(countryList[index].image)
                    .resizable()
                    .cornerRadius(10)
                    .clipped()
                    .padding([.leading, .trailing],10)
            }
        }
        .onAppear {
            setupAppearance()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
    }

    private func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemPink.withAlphaComponent(0.3)
    }
}
