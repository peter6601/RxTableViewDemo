//
//  ViewModelTest.swift
//  RxTableViewBindingDemoTests
//
//  Created by Din Din on 2018/10/31.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import XCTest
import RxSwift

class ViewModelTest: XCTestCase {
    let disposeBag: DisposeBag = DisposeBag()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCreateReport() { 
        let viewModel = ReportViewModel.init()
        viewModel.input.viewDidLoad()
        viewModel.output.newReport.asObserver().subscribe(onNext: { (dependency) in
            guard let report = dependency.report else {
                return
            }
            if let _ = dependency.tag {
            } else {
                XCTAssertEqual(report.userName, "user2", report.userName ?? "")
                XCTAssertEqual(report.content, "problem", report.content ?? "")
            }
            
        }).disposed(by: disposeBag)

        let sb = PublishSubject<Void>()
        let un: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        let ct: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        viewModel.input.bindProblem(ct.asObservable())
        viewModel.input.bindUserName(un.asObservable())
        viewModel.input.bindtapButton(sb.asObservable())
        un.onNext("user2")
        ct.onNext("problem")
        sb.onNext(())
    }
    
    func testEditReport() {
        let report = Report(title: "user1", content: "problem1", userName: "user1", printScreen: nil)
        let tag = 1
        let model = ReportViewModel.Dependency.init(report: report, tag: tag)
        let viewModel = ReportViewModel.init(with: model)
        viewModel.input.viewDidLoad()

        viewModel.output.newReport.asObserver().subscribe(onNext: { (dependency) in
            guard let report = dependency.report else {
                return
            }
            if let _ = dependency.tag {
                XCTAssertEqual(report.userName, "user2", report.userName ?? "")
                XCTAssertEqual(report.content, "problem", report.content ?? "")
            }
            
        }).disposed(by: disposeBag)
        
        let sb = PublishSubject<Void>()
        let un: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        let ct: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        viewModel.input.bindProblem(ct.asObservable())
        viewModel.input.bindUserName(un.asObservable())
        viewModel.input.bindtapButton(sb.asObservable())
        un.onNext("user2")
        ct.onNext("problem")
        sb.onNext(())
    }
    
    func testEmptyReport() {
        let report = Report(title: "user1", content: "problem1", userName: "user1", printScreen: nil)
        let tag = 1
        let model = ReportViewModel.Dependency.init(report: report, tag: tag)
        let viewModel = ReportViewModel.init(with: model)
        viewModel.input.viewDidLoad()
        
        viewModel.output.newReport.asObserver().subscribe(onNext: { (dependency) in
            guard let report = dependency.report else {
                return
            }
            XCTAssertEqual(report.userName, nil, report.userName ?? "")
            XCTAssertEqual(report.content, nil, report.content ?? "")
        }).disposed(by: disposeBag)
        
        let sb = PublishSubject<Void>()
        let un: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        let ct: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        viewModel.input.bindProblem(ct.asObservable())
        viewModel.input.bindUserName(un.asObservable())
        viewModel.input.bindtapButton(sb.asObservable())
        un.onNext(nil)
        ct.onNext(nil)
        sb.onNext(())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
