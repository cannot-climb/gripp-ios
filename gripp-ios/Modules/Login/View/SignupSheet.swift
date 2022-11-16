//
//  LoginSheet.swift
//  gripp-ios
//
//  Created by 조준오 on 2022/10/28.
//

import SwiftUI

struct SignupSheet: View {
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    @Binding var shouldShowLogin : Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var id = ""
    @State var pw = ""
    @State var pw2 = ""
    
    var body: some View {
        VStack{
                TextField("ID(제한사항 추가)", text: $id)
                    .padding(.all, 18)
                    .background(Color(named: "BackgroundSubduedColor"))
                    .foregroundColor(Color(named: "TextSubduedColor"))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                    .padding(.horizontal, 28)
                    .padding(.top, 28)
                    .padding(.bottom, 12)
                    .font(.login_textfield)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    
                SecureField("비밀번호(제한사항 추가)", text: $pw)
                    .padding(.all, 18)
                    .background(Color(named: "BackgroundSubduedColor"))
                    .foregroundColor(Color(named: "TextSubduedColor"))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 12)
                    .font(.login_textfield)
                    
                
                SecureField("비밀번호(다시 입력)", text: $pw2)
                    .padding(.all, 18)
                    .background(Color(named: "BackgroundSubduedColor"))
                    .foregroundColor(Color(named: "TextSubduedColor"))
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 42)
                    .font(.login_textfield)
                
                
                HStack{
                    let width = UIScreen.main.bounds.size.width
                    
                    Button(action:{
                        shouldShowLogin = true
                    }){
                        Text("돌아가기").font(.login_button)
                            .padding(.all, 16)
                            .frame(width: (width-56)/2-12)
                            .background(Color(named: "BackgroundSubduedColor"))
                            .cornerRadius(14)
                            .shadow(color: Color(.black).opacity(0.1), radius: 10)
                            .padding(.trailing, 16)
                            .foregroundColor(Color(named: "TextMasterColor"))
                    }
                    
                    Button(action:{
                        if(pw==pw2){
                            loginViewModel.register(username: id, password: pw)
                        }
                        else{
                        }
                    }){
                        Text("회원 가입").font(.login_button)
                            .padding(.all, 16)
                            .frame(width: (width-56)/2-12)
                            .background(Color("#005DDD"))
                            .cornerRadius(14)
                            .shadow(color: Color(.black).opacity(0.16), radius: 10)
                            .foregroundColor(.white)
                    }
                }
                .onReceive(loginViewModel.registrationSuccess, perform: {
                    loginViewModel.login(username: id, password: pw)
                    
                })
                .onReceive(loginViewModel.loginSuccess, perform: {
                    presentationMode.wrappedValue.dismiss()
                })
                .padding(.horizontal, 28)
        }
    }
}
