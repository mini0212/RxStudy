//
//  ViewController.swift
//  RxStudy
//
//  Created by Min on 24/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let viewModel: LoginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewModelBinding()
    }
    
    func createViewModelBinding() {
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailIDViewModel.data)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordViewModel.data)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .do(onNext: { [unowned self] in
                self.emailTextField.resignFirstResponder()
                self.passwordTextField.resignFirstResponder()
            })
            .subscribe(onNext: { [unowned self] in
                if self.viewModel.validateCredentials() {
                    self.viewModel.loginUser()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func createCallbacks() {
        
        viewModel.isSuccess
            .asObservable()
            .bind { value in
                NSLog("Successful")
            }
            .disposed(by: disposeBag)
        
        viewModel.errorMsg
            .asObservable()
            .bind { errorMessage in
                NSLog("Failure")
            }
            .disposed(by: disposeBag)
    }


}
