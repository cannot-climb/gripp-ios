//
//  ViewRouter.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/03.
//

import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .home
}

enum Page {
    case home
    case leader
    case myGallery
}
