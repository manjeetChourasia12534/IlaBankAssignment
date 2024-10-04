//
//  SearchBarView.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 16, height: 16)
                .tint(Color.gray.opacity(0.7))

            TextField("searchPlaceholder".localized, text: $searchText)

            Spacer()
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    UIApplication.shared.endEditing()
                }) {
                    Image(systemName: "multiply.circle.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(.trailing, 5)
                }
                .tint(.black)
            }
        }
        .padding(10)
        .background(Color("searchBG"))
        .cornerRadius(10)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
