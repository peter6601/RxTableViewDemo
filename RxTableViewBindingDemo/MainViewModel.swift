//
//  MainViewModel.swift
//  RxTableViewBindingDemo
//
//  Created by Din Din on 2018/10/30.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel: ViewModelDependencyType, ViewModelBindingType {
    
    
    var input: MainViewModel.Input!  
    var output: MainViewModel.Output!
    var dependency: MainViewModel.Dependency!
    let disposeBag: DisposeBag = DisposeBag()
    
    struct Dependency {
    }
    
    
    struct Output {
        var listData: BehaviorRelay<[Report]>
    }
    struct Input {
        let viewDidLoad:Observable<Void>
    }
    
    required init(with dependency: MainViewModel.Dependency) {
        self.dependency = dependency
    }
    
    func bind(_ bindings: Input) {
        let listData: BehaviorRelay<[Report]> = BehaviorRelay.init(value: [])      
        bindings.viewDidLoad.asObservable().subscribe(onNext: { (_) in
            let list = [Report(title: "1", content: "1111", userName: "reset", printScreen: nil)]
            listData.accept(list)
        }).disposed(by: disposeBag)
       output = Output.init(listData: listData)
    }
    
}
