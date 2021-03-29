//
//  VideoView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import SwiftUI
import Kingfisher

struct VideoView: View {
    let url: String?
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay(
                    KFImage(Helper.getThumbnailVideo(with: url))
                        .placeholder {
                            PlaceholderView()
                        }
                        .resizable()
                        .fade(duration: 0.3)
                        .cancelOnDisappear(true)
                        .aspectRatio(contentMode: .fill)
                )
                .frame(width: 200)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                )
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .padding(.bottom, 8)
                        .offset(y: 8)
                        .shadow(color: AppColor.shadow, radius: 6, x: 0, y: 6)
                )
            Button {
                //
            } label: {
                Image(.ic_play_white)
            }
            
        }
    }
}
