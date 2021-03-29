//
//  DescriptionView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct DesciptionView: View {
    @Binding var isReadMore: Bool
    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text($title.wrappedValue.uppercased())
                .font(.custom(AppFont.helvetica, size: 24))
                .bold()
                .foregroundColor(AppColor.title)
            Text($description.wrappedValue).lineLimit(isReadMore ? nil : 5)
                .font(.custom(AppFont.helvetica, size: 16))
                .foregroundColor(AppColor.primaryText)
                .animation(.spring())
            HStack {
                Spacer()
                Text($isReadMore.wrappedValue ? "Read less" : "Read more")
                    .font(.custom(AppFont.helvetica, size: 16))
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .onTapGesture {
                    isReadMore.toggle()
                }
            }
            Spacer()
        }
    }
}
