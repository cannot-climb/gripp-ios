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
        VStack(alignment: .leading){
            HStack{
                Text("ID").font(.context).padding(.trailing, 4)
                if(!loginViewModel.validityId(id)){
                    Text("영문과 숫자, 최소 2자").font(.context)
                        .foregroundColor(.red)
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 10)
            if(loginViewModel.shouldCheckUserName){
                HStack{
                    TextField("ID", text: $id)
                        .padding(.all, 18)
                        .background(Color(named: "BackgroundSubduedColor"))
                        .foregroundColor(Color(named: "TextSubduedColor"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                        .padding(.trailing, 12)
                        .padding(.bottom, 12)
                        .font(.login_textfield)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    if(id != ""){
                        Button(action: {
                            loginViewModel.checkUser(username: id)
                        }, label: {
                            Text("중복 확인").font(.login_button)
                                .padding(.all, 18)
                                .background(Color(named: "AccentSubduedColor"))
                                .cornerRadius(12)
                                .shadow(color: Color(.black).opacity(0.1), radius: 10)
                                .padding(.bottom, 12)
                                .foregroundColor(.white)
                        })
                    }
                    else{
                        Text("중복 확인").font(.login_button)
                            .padding(.all, 18)
                            .background(Color(named: "AccentSubduedColor"))
                            .cornerRadius(12)
                            .shadow(color: Color(.black).opacity(0.1), radius: 10)
                            .padding(.bottom, 12)
                            .foregroundColor(.white)
                            .opacity(0.4)
                    }
                }
            }
            else {
                HStack{
                    TextField("", text: $id)
                        .padding(.all, 18)
                        .background(Color(named: "BackgroundSubduedColor"))
                        .foregroundColor(Color(named: "TextSubduedColor"))
                        .cornerRadius(12)
                        .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                        .padding(.trailing, 12)
                        .padding(.bottom, 12)
                        .font(.login_textfield)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .disabled(true)
                        .opacity(0.4)
                    Text("사용 가능").font(.login_button)
                        .padding(.all, 18)
                        .background(Color(named: "BackgroundSubduedColor").opacity(0.3))
                        .cornerRadius(12)
                        .shadow(color: Color(.black).opacity(0.1), radius: 10)
                        .padding(.bottom, 12)
                        .foregroundColor(Color(named: "TextMasterColor"))
                        .disabled(true)
                }
            }
            
            
            
            Divider().padding(.vertical, 10)
            
            HStack{
                Text("비밀번호").font(.context).padding(.trailing, 4)
                if(!loginViewModel.validityPw(pw)){
                    Text("영문과 숫자 필수, 최소 8자").font(.context)
                        .foregroundColor(.red)
                }
                else if(pw != pw2){
                    Text("비밀번호 일치하지 않음").font(.context)
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom, 10)
                    
            SecureField("비밀번호", text: $pw)
                .padding(.all, 18)
                .background(Color(named: "BackgroundSubduedColor"))
                .foregroundColor(Color(named: "TextSubduedColor"))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
                .padding(.bottom, 4)
                .font(.login_textfield)
            
                
            
            SecureField("비밀번호(다시 입력)", text: $pw2)
                .padding(.all, 18)
                .background(Color(named: "BackgroundSubduedColor"))
                .foregroundColor(Color(named: "TextSubduedColor"))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.08), radius: 3, y: 2)
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
                
                if(
                    pw==pw2 &&
                    !loginViewModel.shouldCheckUserName &&
                    loginViewModel.validityId(id) &&
                    loginViewModel.validityPw(pw)
                ){
                    Button(action:{
                        loginViewModel.register(username: id, password: pw)
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
                else{
                    Text("회원 가입").font(.login_button)
                        .padding(.all, 16)
                        .frame(width: (width-56)/2-12)
                        .background(Color("#005DDD"))
                        .cornerRadius(14)
                        .shadow(color: Color(.black).opacity(0.16), radius: 10)
                        .foregroundColor(.white)
                        .opacity(0.4)
                }
            }
            .onReceive(loginViewModel.registrationSuccess, perform: {
                loginViewModel.login(username: id, password: pw)
                
            })
            .onReceive(loginViewModel.loginSuccess, perform: {
                presentationMode.wrappedValue.dismiss()
            })
            
        }
        .padding(.horizontal, 28)
    }
}
