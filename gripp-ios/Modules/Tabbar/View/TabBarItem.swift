//
//  TabBarItem.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/11/03.
//

import SwiftUI

struct TabBarItem: View {
    let title: String
    let icon: Image
    
    @StateObject var viewRouter: ViewRouter
    let assignedPage: Page?

    var body: some View {
        VStack{
            if(viewRouter.currentPage == assignedPage){
                ZStack {
                    icon
                        .foregroundColor(Color(named: "TabBarIconForegroundColor"))
                }
                .padding(12)
                .background(Color(named: "TabBarIconBackgroundColor"))
                .cornerRadius(40)
                .padding(.vertical, 12)
                .shadow(color: Color(named: "TabBarIconBackgroundLTShadowColor"), radius: 5, x:-5, y:-5)
                .shadow(color: Color(named: "TabBarIconBackgroundRBShadowColor"), radius: 5, x:5, y:5)
                .frame(width: 60, height: 60)
            }
            else{
                VStack(alignment: .center){
                    icon.padding(.top, 6)
                    Spacer().frame(height: 5)
                    Text(title)
                        .font(.tabbar_item)
                }
                .frame(width: 60, height: 60)
                
            }
        }
        .onTapGesture {
            if(assignedPage != nil){
                viewRouter.currentPage = assignedPage!
            }
        }
    }
    
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TabBarItem(title: "홈", icon: Image("Home"), viewRouter: ViewRouter(), assignedPage: .home)
            TabBarItem(title: "리더보드", icon: Image("Leaderboard"), viewRouter: ViewRouter(), assignedPage: .leader)
        }
    }
}