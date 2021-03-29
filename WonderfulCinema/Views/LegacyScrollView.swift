//
//  LegacyScrollView.swift
//  WonderfulCinema
//
//  Created by Nguyen Chi Thanh on 26/03/2021.
//

import UIKit
import SwiftUI

struct LegacyScrollView<Content: View>: UIViewRepresentable {
    
    @Binding var isRefreshing: Bool
    let content: () -> Content
    
    init(isRefreshing: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._isRefreshing = isRefreshing
        self.content = content
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let hosting = UIHostingController(rootView: content())
        let scrollView =  UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        let refresh = UIRefreshControl()
        refresh.addTarget(context.coordinator, action: #selector(context.coordinator.pullToRefresh(sender:)), for: .valueChanged)
        scrollView.refreshControl = refresh
        scrollView.addSubview(hosting.view)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        hosting.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        hosting.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        hosting.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        hosting.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        if !context.coordinator.isRefreshing.wrappedValue {
            uiView.refreshControl?.endRefreshing()
        }
    }
        
    func makeCoordinator() -> Coordinator {
        Coordinator($isRefreshing)
    }
    
    class Coordinator: NSObject {
        var isRefreshing: Binding<Bool>
        
        init(_ isRefreshing: Binding<Bool>) {
            self.isRefreshing = isRefreshing
        }
        
        @objc func pullToRefresh(sender: UIRefreshControl) {
            isRefreshing.wrappedValue = sender.isRefreshing
        }
    }
    
}
