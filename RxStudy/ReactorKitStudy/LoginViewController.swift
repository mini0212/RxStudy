//
//  LoginViewController.swift
//  RxStudy
//
//  Created by Min on 21/08/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit
import ReactorKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController, StoryboardView {
    
    // MARK: - IBOutlet
    @IBOutlet weak var idTf: UITextField!
    @IBOutlet weak var pwTf: UITextField!
    @IBOutlet weak var loginActionLb: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    var disposeBag: DisposeBag = DisposeBag()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        initTextField()
//        initButton()
        // Do any additional setup after loading the view.
    }
    
    private func initTextField() {
        self.idTf.placeholder = "Enter Email"
        self.pwTf.placeholder = "Enter Password"
    }
    
    private func initButton() {
        self.loginBtn.setTitle("Login", for: .normal)
    }
    

    func bind(reactor: LoginReactorView) {
        //binding here
        
        self.idTf.rx.text
            .orEmpty
            .map { LoginReactorView.Action.id($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.pwTf.rx.text
            .orEmpty
            .map { LoginReactorView.Action.pw($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        self.loginBtn.rx.tap
            .map { LoginReactorView.Action.login }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // state
        reactor.state
            .map { $0.isEnableButton }
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.completeText }
            .bind(to: loginActionLb.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    
}
