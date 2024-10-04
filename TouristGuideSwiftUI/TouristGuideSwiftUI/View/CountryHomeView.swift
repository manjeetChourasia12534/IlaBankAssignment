//
//  CountryHomeView.swift
//  TouristGuideSwiftUI
//
//  Created by Neosoft on 03/10/24.
//

import SwiftUI

struct CountryHomeView: View {
    @StateObject var viewModel = CountryViewModel()
    @State private var isFloatingButtonClicked = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                contentView
                floatingButton
            }
            .navigationTitle(viewModel.getNavigationTitle())
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isFloatingButtonClicked) {
                StatisticsDataSheetView(data: viewModel.getStatisticsData()) {
                    isFloatingButtonClicked = false
                }
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(230)])
                    .presentationCornerRadius(25)
            }
        }
    }

    private var contentView: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(message: errorMessage)
            } else {
                mainContentView
            }
        }
    }

    private var loadingView: some View {
        ProgressView("loading".localized)
            .progressViewStyle(CircularProgressViewStyle())
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private func errorView(message: String) -> some View {
        VStack {
            Text("error".localized)
                .font(.headline)
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
        }
    }

    private var mainContentView: some View {
        ScrollView {
            CountryImageCarouselView(countryList: $viewModel.countries, selectedIndex: $viewModel.selectedIndex)
                .frame(height: UIScreen.main.bounds.height * 0.25)
                .listRowSeparator(.hidden)

            LazyVStack(pinnedViews: [.sectionHeaders]) {
                Section(header: searchBar) {
                    if viewModel.touristSpots.isEmpty {
                        NoDataView()
                            .padding(.horizontal, 10)
                            .listRowSeparator(.hidden)
                    } else {
                        ForEach(viewModel.touristSpots, id: \.self) { spot in
                            TouristSpotCellView(touristSpot: spot)
                                .listRowSeparator(.hidden)
                                .padding(.horizontal, 10)
                        }
                        .listRowSpacing(0)
                    }
                }
            }
            .onChange(of: viewModel.selectedIndex) {
                UIApplication.shared.endEditing()
            }
        }
        .listStyle(.plain)
        .dismissKeyboardOnTap()
    }

    private var searchBar: some View {
        SearchBarView(searchText: $viewModel.searchText)
            .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
            .padding(10)
    }

    private var floatingButton: some View {
        Button(action: {
            isFloatingButtonClicked.toggle()
        }) {
            Image(systemName: "ellipsis")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .rotationEffect(.degrees(90))
                .padding(10)
                .background(Color.indigo)
                .cornerRadius(30)
                .padding()
                .foregroundColor(.white)
        }
    }
}

#Preview {
    CountryHomeView()
}
