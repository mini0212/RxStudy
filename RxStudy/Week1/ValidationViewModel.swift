//
//  ValidationViewModel.swift
//  RxStudy
//
//  Created by Min on 23/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import Foundation
import RxSwift


protocol ValidationViewModel {
    
    var errorMessage: String { get }
    
    // Observables
    var data: Variable<String> { get set }
    var errorValue: Variable<String?> { get }
    
    // Validation
    func validateCredentials() -> Bool
}

class PasswordViewModel: ValidationViewModel {
    var errorMessage: String = "Please enter a valid Password"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        
        guard validateLength(text: data.value, size: (6,15)) else {
            errorValue.value = errorMessage
            return false
        }
        
        errorValue.value = ""
        return true
    }
    
    func validateLength(text: String, size: (min: Int, max: Int)) -> Bool {
        return (size.min...size.max).contains(text.count)
    }
}

class EmailIDViewModel: ValidationViewModel {
    var errorMessage: String = "Please enter a valid Email ID"
    
    var data: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable("")
    
    func validateCredentials() -> Bool {
        guard validatePattern(text: data.value) else {
            errorValue.value = errorMessage
            return false
        }
        
        errorValue.value = ""
        return true
    
    }
    
    func validatePattern(text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
}
