//
//  LoginViewModel.swift
//  RxStudy
//
//  Created by Min on 24/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let model: LoginModel = LoginModel()
    let disposeBag = DisposeBag()
    
    // Initialize ViewModel's
    let emailIDViewModel = EmailIDViewModel()
    let passwordViewModel = PasswordViewModel()
    
    // Fields that bind to our view's
    let isSuccess: Variable<Bool> = Variable(false)
    let isLoading: Variable<Bool> = Variable(false)
    let errorMsg: Variable<String> = Variable("")
    
    func validateCredentials() -> Bool {
        return emailIDViewModel.validateCredentials() && passwordViewModel.validateCredentials()
    }
    
    func loginUser() {
        
        // Initialize model with filed values
        model.email = emailIDViewModel.data.value
        model.password = passwordViewModel.data.value
        
        self.isLoading.value = true
        
//        let result = Request
    }
    
}
