//
//  TabBarItem.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/03.
//

import SwiftUI

struct TabBarItem: View {
    let title: String
    let iconString: String
    
    @StateObject var viewRouter: ViewRouter
    var assignedPage: Page?
    
    var body: some View {
        VStack(alignment: .center){
            Image(iconString)
                .resizable()
                .frame(width: viewRouter.currentPage == assignedPage ? 28 : 24, height: viewRouter.currentPage == assignedPage ? 28 : 24)
                .foregroundColor(viewRouter.currentPage == assignedPage ? Color(named: "TabBarIconForegroundColor") : Color(named: "TextMasterColor"))
                .padding(10)
                .background(viewRouter.currentPage == assignedPage ? Color(named: "TabBarIconBackgroundColor") : Color(named: "BackgroundMasterColor").opacity(0))
                .cornerRadius(40)
                .padding(.bottom, -10)
                .padding(.top, viewRouter.currentPage == assignedPage ? -10 : -6)
                .shadow(color: viewRouter.currentPage == assignedPage ? Color(named: "TabBarIconBackgroundLTShadowColor") : .black.opacity(0), radius: 5, x:-5, y:-5)
                .shadow(color: viewRouter.currentPage == assignedPage ? Color(named: "TabBarIconBackgroundRBShadowColor") : .black.opacity(0), radius: 5, x:5, y:5)
//            Spacer().frame(height: viewRouter.currentPage == assignedPage ? 0 : 5)
            if(viewRouter.currentPage != assignedPage){
                Text(title)
                    .font(.tabbar_item)
            }
            
        }
        
        .frame(width: 60, height: 80)
        .contentShape(Rectangle())
        .onTapGesture {
            if(assignedPage != nil && viewRouter.currentPage != assignedPage){
                viewRouter.apply(page: assignedPage!)
            }
        }
    }
    
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TabBarItem(title: "홈", iconString: "Home", viewRouter: ViewRouter(), assignedPage: .home)
            TabBarItem(title: "리더보드", iconString: "Leaderboard", viewRouter: ViewRouter(), assignedPage: .leader)
        }
    }
}
