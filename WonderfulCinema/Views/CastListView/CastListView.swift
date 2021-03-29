//
//  CastListView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import SwiftUI
import Kingfisher

struct CastListView: View {
    @StateObject var viewModel: CastListDatasource
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible(minimum: 150))]) {
                ForEach(Array(viewModel.casts.enumerated()), id: \.0) { index, item in
                    CastView(url: item.profilePath, name: item.name, character: item.character)
                        .frame(maxWidth: 86)
                        .padding(index < viewModel.casts.count - 1 ? .leading : .horizontal)
                }
            }
        }
    }
}

struct CastListView_Previews: PreviewProvider {
    static var previews: some View {
        CastListView(viewModel: CastListDatasource(movieID: 13, movieAPI: MovieAPI()))
    }
}
