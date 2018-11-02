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
    var didTapButton: PublishSubject<Void> {get set}
    var userName: BehaviorRelay<String?>  {get set}
    var problem: BehaviorRelay<String?>  {get set}
    func bindProblem(_ problem: Observable<String?>)
    func bindUserName(_ userName: Observable<String?>)
    func bindtapButton(_ didTapButton: Observable<Void>)
}

protocol ReprotViewModelOutput {
    var newReport: PublishSubject<ReportViewModel.Dependency> {get set}

}

protocol ReprotViewModelDependency {
    var report: Report?  {get set}
    var tag: Int?  {get set}

}

class ReportViewModel: ViewModelDependencyType, ReportViewModelInput, ReprotViewModelOutput {
    
    func bindProblem(_ problem: Observable<String?>) {
        problem.subscribe(onNext: { [weak self](event) in
            self?.problem.accept(event)
        }).disposed(by: disposBag)
    }
    
    func bindUserName(_ userName: Observable<String?>) {
        userName.subscribe(onNext: { [weak self](user) in
            self?.userName.accept(user)
        }).disposed(by: disposBag)
    }
    
    func bindtapButton(_ didTapButton: Observable<Void>) {
        didTapButton.subscribe { [weak self](_) in
            guard let _userName = self?.userName.value, let _problem = self?.problem.value , !_problem.isEmpty, !_userName.isEmpty  else {
                return
            }
            guard var report = self?.dependency.report else {
                let report = Report.init(title: _userName, content: _problem, userName: _userName, printScreen: nil)
                let model = Dependency(report: report, tag: nil)
                self?.output.newReport.onNext(model)
                return
            }
            report.content = _problem
            report.userName = _userName
            let model = Dependency(report: report, tag: self?.dependency.tag)
            self?.output.newReport.onNext(model)
            }.disposed(by: disposBag)
    }
    

    var didTapButton: PublishSubject<Void> = PublishSubject<Void>()
    var newReport = PublishSubject<ReportViewModel.Dependency>()
    var userName: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    var problem: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let disposBag: DisposeBag = DisposeBag()
    var input: ReportViewModelInput { return self }
    var output: ReprotViewModelOutput {return self }
    var dependency: Dependency!
    
    required init(with dependency: Dependency) {
        self.dependency = dependency
    }
    
    init() {
        dependency = Dependency.init()
    }
    
    struct Dependency {
        var report: Report?
        var tag: Int?
    }
    
    func viewDidLoad() {
        //API
    }
}
