//
//  Color +++.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 27/03/2021.
//

import Foundation
import SwiftUI

extension Color {
    private func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        let uiColor = UIColor(self)
        if uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> Color {
        if let newColor = self.adjust(by: abs(percentage)) {
            return Color(newColor)
        }
        return self
    }
    
    func darker(by percentage: CGFloat = 30.0) -> Color {
        if let newColor = self.adjust(by: -1 * abs(percentage)) {
            return Color(newColor)
        }
        return self
    }
}
