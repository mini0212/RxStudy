//
//  LoginReactorView.swift
//  RxStudy
//
//  Created by Min on 21/08/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

class LoginReactorView: Reactor {
    
    enum Action {
        // actiom cases
//        case login(id: String, pw: String) state에 이미 값이 있기 때문에 값을 받을 필요가 없다
        case login
        case id(String)
        case pw(String)
    }
    
    enum Mutation { // 받은 데이터로 무엇을 할 것인지
        // mutation cases
//        case validateLogin(id: String, pw: String)
        case validateLogin
        case validate(Bool)
        case setID(String)
        case setPW(String)
    }
    
    struct State {
        //state
        var id: String?
        var pw: String?
        var isEnableButton: Bool
        var completeText: String
    }
    
    let initialState: State
    
    init() {
        // init state initialState = State(...)
        self.initialState = State(id: nil, pw: nil, isEnableButton: false, completeText: "로그인 전")
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
         switch action {
            
         case .id(let idString):
//            return Observable.just(Mutation.setID(idString))
            return Observable.concat([
                Observable.just(Mutation.setID(idString)),
                Observable.just(Mutation.validate(self.validate(id: idString, pw: currentState.pw)))
                ])
         case .pw(let pwString):
//            return Observable.just(Mutation.setPW(pwString))
            return Observable.concat([
                Observable.just(Mutation.setPW(pwString)),
                Observable.just(Mutation.validate(self.validate(id: currentState.id, pw: pwString)))
                ])
         case .login:
            return Observable.just(Mutation.validateLogin)

        }
    }
    
    // concat은 실행이 순서대로 된다
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
         switch mutation {
         case .setID(let id):
            newState.id = id
            newState.isEnableButton = validate(id: newState.id, pw: newState.pw)
         case .setPW(let pw):
            newState.pw = pw
            newState.isEnableButton = validate(id: newState.id, pw: newState.pw)
         case .validate(let valid):
            newState.isEnableButton = valid
         case .validateLogin:
            if state.isEnableButton {
                newState.completeText = "성공"
            } else {
                newState.completeText = "실패"
            }
        }
        return newState
    }
    
    // 아이디와 비밀번호가 맞는지 검증
    private func validate(id: String?, pw: String?) -> Bool {
        guard let id = id, let pw = pw else {
            return false
        }
        return id.count > 6 && pw.count > 4 // id 가 6자 이상 pw가 4자 이상
        
    }
    
}
