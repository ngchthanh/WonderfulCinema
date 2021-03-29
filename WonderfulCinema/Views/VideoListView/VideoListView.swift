//
//  VideoListView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation
import SwiftUI
import Kingfisher

struct VideoListView: View {
    @StateObject var viewModel: VideoListDatasource
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 140))]) {
                ForEach(0..<viewModel.videos.count, id: \.self) { index in
                    VideoView(url: viewModel.videos[index].key)
                        .padding(index < viewModel.videos.count - 1 ? .leading : .horizontal)
                        .padding(.bottom, 24)
                }
            }
        }
    }
}

