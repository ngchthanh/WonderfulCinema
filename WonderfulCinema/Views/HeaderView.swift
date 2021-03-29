//
//  HeaderView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 25/03/2021.
//

import SwiftUI

struct HeaderView<LeftContent: View, RightContent: View>: View {
    private let leftContent: LeftContent
    private let rightContent: RightContent
    
    init(@ViewBuilder leftContent: () -> LeftContent, @ViewBuilder rightContent: () -> RightContent) {
        self.leftContent = leftContent()
        self.rightContent = rightContent()
    }
    
    var body: some View {
        HStack {
            leftContent
            Spacer()
            rightContent
        }
    }
}
