//
//  LoginModel.swift
//  RxStudy
//
//  Created by Min on 23/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import Foundation

class LoginModel {
    
    var email: String = ""
    var password: String = ""
    
    convenience init(email: String,
                     password: String) {
        self.init()
        self.email = email
        self.password = password
    }
    
}
