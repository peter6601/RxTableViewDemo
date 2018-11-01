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
    func bind(with bindings: ReportViewModel.Input)
}
protocol ReprotViewModelOutout {
    var newReport: PublishSubject<ReportViewModel.Dependency> {get set}
}

class ReportViewModel: ViewModelDependencyType, ReportViewModelInput, ReprotViewModelOutout  {

    var newReport = PublishSubject<ReportViewModel.Dependency>()
    let userName: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let content: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    typealias ViewModelInput = ReportViewModel.Input
    let disposBag: DisposeBag = DisposeBag()
    var input: ReportViewModelInput { return self }
    var output: ReprotViewModelOutout {return self }
    var dependency: Dependency!
    
    required init(with dependency: Dependency) {
        self.dependency = dependency
        self.userName.accept(dependency.report?.userName)
        self.content.accept(dependency.report?.content)
    }
    
    init() {
        self.dependency = ReportViewModel.Dependency(report: nil, tag: 0)
    }
    
    struct Dependency {
        var report: Report?
        var tag: Int?
    }
    
    struct Input {
        let didTapButton: Observable<Void>
        let userName: Observable<String?>
        let problem: Observable<String?>
    }
    
    struct Output {
        let userName: ControlProperty<String?>
        let problem: ControlProperty<String?>
    }
    
    func viewDidLoad() {
        //API
    }
    
    func bindOutput(with bindings: ReportViewModel.Output) {
        self.content.bind(to: bindings.problem).dispose()
        self.userName.bind(to: bindings.userName).dispose()
    }
    
    func bind(with bindings: ReportViewModel.Input) {
        
        bindings.problem.subscribe(onNext: { [weak self](event) in
            self?.content.accept(event)
        }).disposed(by: disposBag)

        bindings.userName.subscribe(onNext: { [weak self](user) in
            self?.userName.accept(user)
        }).disposed(by: disposBag)

        bindings.didTapButton.subscribe { (_) in
            guard var report = self.dependency.report else {
                let report = Report.init(title: self.userName.value, content: self.content.value, userName: self.userName.value ?? "", printScreen: nil)
                let model = Dependency(report: report, tag: nil)
                self.output.newReport.onNext(model)
                return
            }
            report.content = self.content.value
            report.userName = self.userName.value
            let model = Dependency(report: report, tag: self.dependency.tag)
            self.output.newReport.onNext(model)
        }.disposed(by: disposBag)
    }
}
