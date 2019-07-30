//
//  RxTableViewController.swift
//  RxStudy
//
//  Created by Min on 30/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        bindTableViewOne()
//        bindTableViewTwo()
//        bindTableViewThree()
        bindTableViewFour()
    }

    
    // tableView.rx.items 사용
    private func bindTableViewOne() {
        
        let cities: [String] = ["London", "Vienna", "Lisbon"]
        let citiesOb: Observable<[String]> = Observable.of(cities)
        
        citiesOb.bind(to: tableView.rx.items) { (tableView, index, element) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RxTableTableViewCell.identifier) else { return UITableViewCell() }
            
            cell.textLabel?.text = element
            return cell
    
        }.disposed(by: disposeBag)
    }
    
    // tableView.rx.items(cellIdentifier: String) 사용
    private func bindTableViewTwo() {
        
        let cities: [String] = ["London", "Vienna", "Lisbon"]
        let citiesOb: Observable<[String]> = Observable.of(cities)
        
        citiesOb.bind(to: tableView.rx.items(cellIdentifier: RxTableTableViewCell.identifier)) { (index, element, cell) in
            cell.textLabel?.text = element
        }.disposed(by: disposeBag)
    }
    
    
    // tableView.rx.items(cellIdentifier: String, cellType: Cell.Type) 사용
    // RxTableViewCell class 를 만들어주고 cell의 프로퍼티를 사용
    private func bindTableViewThree() {
       
        self.tableView.register(UINib(nibName: RxTableTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RxTableTableViewCell.identifier)
        
        
        let cities: [String] = ["London", "Vienna", "Lisbon"]
        let citiesOb: Observable<[String]> = Observable.of(cities)
        
        citiesOb.bind(to: tableView.rx.items(cellIdentifier: RxTableTableViewCell.identifier, cellType: RxTableTableViewCell.self)) { (index, element, cell) in
            cell.valueLabel.text = element
        }.disposed(by: disposeBag)
    }


    // tableView.rx.items(dataSource: protocol<RxTableViewDataSourceType, UITableViewDataSource>) 사용
    // cocoapod에 RxDataSources install
    private func bindTableViewFour() {
        
        let cities = ["London", "Vienna", "Lisbon"]
    
        let configureCell: (TableViewSectionedDataSource<SectionModel<String, String>>, UITableView,IndexPath, String) -> UITableViewCell = { (datasource, tableView, indexPath,  element) in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RxTableTableViewCell.identifier, for: indexPath) as? RxTableTableViewCell else { return UITableViewCell() }
            
            cell.textLabel?.text = element
            
            return cell
            
        }

        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>.init(configureCell: configureCell)
        datasource.titleForHeaderInSection = { datasource, index in
            
            return datasource.sectionModels[index].model
            
        }
        
        let sections = [
            SectionModel<String, String>(model: "first section", items: cities),
            SectionModel<String, String>(model: "second section", items: cities)
            
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)

    }
    
    
    typealias CitySectionModel = SectionModel<String, String>
    typealias CityDataSource = RxTableViewSectionedReloadDataSource<CitySectionModel>
    
    private func bindTableViewFive() {
        
        self.tableView.register(UINib(nibName: RxTableTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RxTableTableViewCell.identifier)
        
        
        let firstCities = ["London", "Vienna", "Lisbon"]
        let secondCities = ["Paris", "Madrid", "Seoul"]
        
        let sections = [
            SectionModel<String, String>(model: "first section", items: firstCities),
            SectionModel<String, String>(model: "second section", items: secondCities)
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: cityDataSource))
            .disposed(by: disposeBag)
        
        
    }
    
    private var cityDataSource: CityDataSource {
        let configureCell: (TableViewSectionedDataSource<CitySectionModel>, UITableView, IndexPath, String) -> UITableViewCell = { (datasource, tableView, indexPath, element) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RxTableTableViewCell.identifier, for: indexPath) as? RxTableTableViewCell else {
                return UITableViewCell()
            }
            
            cell.valueLabel.text = element
            
            return cell
        }
        
        let datasource = CityDataSource.init(configureCell: configureCell)
        datasource.titleForHeaderInSection = { (datasource, index) in
            return datasource.sectionModels[index].model
        }
        
        return datasource
    }
    
}

/*
 참고
 https://eunjin3786.tistory.com/29
 */
