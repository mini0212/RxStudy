//
//  ViewController.swift
//  RxStudy
//
//  Created by Min on 29/05/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



class MainViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let observerSubject = BehaviorRelay<String>(value: "옵저버subject")
    
    let subject = BehaviorRelay<String>(value: "초기값")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        subject.bind(to: observerSubject).disposed(by: disposeBag)
//
//        subject.subscribe(onNext: { (string) in
//            self.label.text = string
//        }).disposed(by: disposeBag)
//
//        subject.bind(to: label.rx.text).disposed(by: disposeBag)
//
//        Observable<Int>
//            .create { observer -> Disposable in
//                observer.on(Event.next(1))
//                observer.on(Event.next(2))
//                observer.on(Event.next(3))
//                observer.onCompleted()
//                return Disposables.create()
//            }.subscribe({ (event: Event<Int>) in
//                switch event {
//                case let .next(element):
//                    print("element: \(element)")
//                case let .error(error):
//                    print("error: \(error.localizedDescription)")
//                case let .completed:
//                    print("completed")
//                }
//            }).disposed(by: disposeBag)
//
//        textField.rx.text
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
//
//
//        self.label.rx.observe(String.self, "text")
//            .subscribe { (event: Event<String?>) in
//                switch event {
//                case .next(let text):
//                    print("label: \(text)")
//                default:
//                    break
//                }
//            }.disposed(by: disposeBag)
        
    }
}

// rx의 schedulser = thread
