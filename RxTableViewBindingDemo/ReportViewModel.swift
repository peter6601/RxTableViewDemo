//
//  ReportViewModel.swift
//  RxTableViewBindingDemo
//
//  Created by Din Din on 2018/10/31.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ReportViewModelInput {
    func viewDidLoad()
}
protocol ReprotViewModelOutout {
    var newReport: PublishSubject<Report?> {get set}
}

class ReportViewModel: ViewModelDependencyType, ReportViewModelInput, ReprotViewModelOutout  {

    var newReport = PublishSubject<Report?>()
    let userName: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
    let content: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
    
    let disposBag: DisposeBag = DisposeBag()
    var input: ReportViewModelInput { return self }
    var output: ReprotViewModelOutout {return self }
    var dependency: Report!
    
    required init(with dependency: Report) {
        self.dependency = dependency
    }
    init() {
        
    }
    
    struct Input {
        let didTapButton: Observable<Void>
        let userName: Observable<String?>
        let problem: Observable<String?>
    }
    
    struct Output {
        let reportData: BehaviorRelay<Report?>
    }
    
    func viewDidLoad() {
        //API
    }
    
    func bind(with bindings: ReportViewModel.Input) {
        
        bindings.problem.subscribe { [weak self](event) in
            self?.content.on(event)
            print("content \(event)")
        }.disposed(by: disposBag)
    
        bindings.userName.subscribe(onNext: { [weak self](user) in
            self?.userName.onNext(user)
            print("userName \(user)")
        }).disposed(by: disposBag)
        
        bindings.didTapButton.subscribe { (_) in
            let report = Report.init(title: self.userName.value(), content: self.content.value(), userName: self.userName.value() ?? "", printScreen: nil)
            self.output.newReport.onNext(report) 
        }.disposed(by: disposBag)
        
//         bindings.didTapButton.withLatestFrom(content.asObservable()).withLatestFrom(userName.asObservable()) { (p, c) -> Report in
//            let report = Report.init(title: c, content: p, userName: c ?? "", printScreen: nil)
//            return report
//            }.subscribe { (report) in
//                self.output.newReport.on(report) 
//        }.disposed(by: disposBag)
     
    }
}
