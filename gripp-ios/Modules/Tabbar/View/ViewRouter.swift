//
//  ViewRouter.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/03.
//

import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .initial
    
    func apply(page: Page) {
        withAnimation(.easeInOut(duration: 0.25)){
            impactLight.impactOccurred()
            currentPage = page
        }
    }
}

enum Page {
    case home
    case leader
    case myGallery
    case initial
}
