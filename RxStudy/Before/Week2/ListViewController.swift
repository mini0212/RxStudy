//
//  ListViewController.swift
//  RxStudy
//
//  Created by Min on 06/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/*
 - 20개의 배열을 만들고
 - 배열을 바인딩해서 테이블뷰를 그려보시오
 - datasource와 delegate 프로토콜 사용금지
 - 셀 레이아웃은 자유
 - 배열의 object도 자유
 */

class ListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let arrays = Observable<[String]>.just([String](repeating: "text", count: 20))
    let items = BehaviorRelay(value: [String]())
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initTableView()
        setTableViewSelect()
    }

    func initTableView() {
        self.tableView.register(UINib(nibName: ListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ListTableViewCell.identifier)  // 안하면 에러남-_-;
        
//        let array = [String](repeating: "text", count: 20)  // 더미데이터 생성
//        let obArray = Observable.of(array)
        
        // items를 구독하는 모든 것에 값을 넣어서 observable
        Observable<[String]>
            .just([String](repeating: "observable", count: 20))
            .bind(to: items)
            .disposed(by: disposeBag)
        
        // accept -> 전역으로 선언된 items 에 값을 넣어줌 
//        items.accept([String](repeating: "item", count: 20))
        
        // self 사용할때 escaping closure 인지 확인 후 weak self, unowned self 걸어주기
        items
            .bind(to: self.tableView.rx.items(cellIdentifier: ListTableViewCell.identifier, cellType: ListTableViewCell.self)) { (index, element, cell) in
                
            cell.setData(element)
        }.disposed(by: disposeBag)
        
        // 필요한 것만 리로드
        // 11 이상
        tableView.performBatchUpdates( {
            tableView.insertRows(at: [], with: .automatic)
            tableView.deleteRows(at: [], with: .automatic)
            tableView.reloadRows(at: [], with: .automatic)
        })
        
        // 11이하
        tableView.beginUpdates()
        
        tableView.insertRows(at: [], with: .automatic)
        tableView.deleteRows(at: [], with: .automatic)
        tableView.reloadRows(at: [], with: .automatic)
        
        tableView.endUpdates()
        
        // rx에서는 rxDataSource로 변경되는 애니메이션을 주기위해? 간편하게 가능!!
        
    }
    
    // 값을 삭제할 때 값을 바로 삭제하면 안되고 값을 삭제 하고 accept로 테이블 뷰에 값을 넣어줌

    func setTableViewSelect() {
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
//        .itemSelected
//            .subscribe(onNext: { indexPath in
//            print("\(indexPath.row)")
//        }).disposed(by: disposeBag)
    }
    
 
}
