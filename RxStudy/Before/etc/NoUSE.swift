////
////  NoUSE.swift
////  RxStudy
////
////  Created by Min on 24/06/2019.
////  Copyright © 2019 seongmin. All rights reserved.
////
//
//import Foundation
//
//class MainViewController: UIViewController {
//    
//    @IBOutlet weak var textField: UITextField!
//    
//    let label: UILabel = UILabel()
//    
//    let disposeBag = DisposeBag()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        let string = "ab2v9bc13j5jf4jv21"
//        let numberArray = (try? NSRegularExpression(pattern: "[0-9]+")
//            .matches(in: string,
//                     range: NSRange(string.startIndex..., in: string))
//            .flatMap { Range($0.range, in: string) }
//            .map { String(string[$0]) }) ?? []
//        let r = numberArray
//            .flatMap{ (number: String) -> Int? in
//                return Int(number)
//            }.filter { (value: Int) -> Bool in
//                return value % 2 != 0
//            }.map { $0 * $0 }
//            .reduce(0, +)
//        print(r)
//        
//        self.textField.rx.text
//            .bind(to: label.rx.text)
//            ////            .subscribe(onNext: { (value) in
//            //            print(value)
//            //        })
//            .disposed(by: disposeBag)
//        
//        
//        
//        bind()
//        
//    }
//    
//    func bind() {
//        viewModel.obString.bind(to: label.rx.text).disposed(by: disposeBag)
//    }
//    
//    let viewModel = ViewModel()
//    
//}
//
//
//class ViewModel {
//    
//    let model = Model()
//    
//    var obString: Observable<String> {
//        return model.text.asObservable()
//    }
//    
//    
//}
//
//class Model {
//    let text = BehaviorRelay<String>(value: "메롱")
//}
