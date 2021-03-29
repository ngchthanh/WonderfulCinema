//
//  GenreListView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct GenreListView: View {
    @StateObject var viewModel: GenreListDatasource
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.height * 2
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(0..<viewModel.genres.count, id: \.self) { index in
                            GenreView(title: viewModel.genres[index].name ?? "", isOdd: index % 2 == 1)
                                .id(index)
                                .frame(width: width, height: geo.size.height)
                                .padding(index < viewModel.genres.count - 1 ? .leading : .horizontal)
                        }
                    }
                }.onReceive(viewModel.$hasFinishedRefreshing, perform: { value in
                    if value == true {
                        withAnimation {
                            scrollView.scrollTo(0, anchor: .top)
                        }
                    }
                })
            }
        }
    }
}

struct GenreListView_Previews: PreviewProvider {
    static var previews: some View {
        GenreListView(viewModel: GenreListDatasource(movieAPI: MovieAPI()))
    }
}
