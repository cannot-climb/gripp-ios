//
//  DefaultView.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/12/01.
//

import Foundation
import SwiftUI
import Alamofire
import Combine

struct InitialView: View {
    @State var homeViewModel: HomeViewModel
    @State var initialViewModel: InitialViewModel
    @State var viewRouter: ViewRouter

    var body: some View {
        LoadAnimationView(alwaysDark: false)
            .frame(width: 100, height: 100)
            .onAppear(perform: {
                initialViewModel.initialize(homeViewModel, viewRouter)
            })
    }
}
