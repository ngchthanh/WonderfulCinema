//
//  ReviewListView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import SwiftUI

struct ReviewListView: View {
    @StateObject var viewModel: ReviewListDatasource
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100))]) {
                ForEach(Array(viewModel.reviews.enumerated()), id: \.1) { index, item in
                    ReviewView(name: item.author ?? "", comment: item.content ?? "", stars: item.authorDetails?.rating ?? 0, date: Date(), url: item.authorDetails?.avatarPath)
                        .padding()
                        .onAppear {
                            viewModel.loadMoreIfNeedPS.send(index)
                        }
                }
            }
        }
    }
}
