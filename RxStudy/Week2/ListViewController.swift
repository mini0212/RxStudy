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
    
    let cell: String = "ListTableViewCell"
    
    let arrays = Observable<[String]>.just([String](repeating: "text", count: 20))

    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        initTableView()
        setTableViewSelect()
    }

    func initTableView() {
        self.tableView.register(UINib(nibName: self.cell, bundle: nil), forCellReuseIdentifier: self.cell)  // 안하면 에러남-_-;
        
//        let array = [String](repeating: "text", count: 20)  // 더미데이터 생성
//        let obArray = Observable.of(array)
        
        arrays
            .bind(to: self.tableView.rx.items(cellIdentifier: self.cell, cellType: ListTableViewCell.self)) { index, element, cell in
                
            cell.setData(element)
        }.disposed(by: disposeBag)
        
    }
    
    

    func setTableViewSelect() {
        self.tableView.rx.setDelegate(self).disposed(by: disposeBag)
//        .itemSelected
//            .subscribe(onNext: { indexPath in
//            print("\(indexPath.row)")
//        }).disposed(by: disposeBag)
    }
    
 
}
