//
//  LoginViewController.swift
//  RxStudy
//
//  Created by Min on 28/06/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 
 - 이메일 패스워드 입력필드 생성
 - 로그인버튼 생성(디폴트상태는 disabled)
 - 이메일 패스워드를 입력받고 맞으면 로그인버튼 활성화(실시간)
 - 이메일검증은 @포함여부
 - 패스워드는 6자리 이상일경우
 
 */

class BeforeLoginViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    let disposeBag: DisposeBag = DisposeBag()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initTextField()
        initButton()
        bind()
        
    }
    
    
    func initTextField() {
        self.emailTextField.placeholder = "이메일을 입력하세요"
        
        self.passTextField.placeholder = "비밀번호를 입력하세요"
        self.passTextField.isSecureTextEntry = true
    }
    
    func initButton() {
        self.loginButton.setTitle("로그인", for: .normal)
        
    }
    
    func bind() {
        
        let emailValid = emailTextField.rx.text
            .orEmpty
            .asObservable()
            .map {
                $0.contains("@") && $0.contains(".")
        }
        
        let passValid = passTextField.rx.text
            .orEmpty
            .asObservable()
            .map {
                $0.count > 6
        }
        
        // 이메일 형식에 따라 라벨이 바뀜
        emailTextField.rx.text
            .orEmpty
            .asObservable()
            .map { ($0.contains("@") && $0.contains(".")) ? "이메일 형식이 맞습니다" : "이메일 형식이 틀립니다" }
            .bind(to: emailLabel.rx.text)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .asObservable()
            .map { $0.count > 6 ? "비밀번호 형식이 맞습니다" : "비밀번호 형식이 틀립니다" }
            .bind(to: passLabel.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(emailValid, passValid) { $0 && $1 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        // if 조건문을 쓰기 전에 생각하기
        
//        let isValid = Observable.combineLatest(email, pass) { $0 && $1 }
//
//        // combineLatest -> 최대 8개
//
//        isValid
//            .bind(to: loginButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
    }
}

// flatMap: 이벤트들을 관리할 수 있는?

// BehaviorRelay + skip(1)을 쓸바에는 PublishRelay를 써라

// distinctUtilChanged - 직전에 들어온 값과 지금 들어온 값이 다를때만 이벤트 발생
