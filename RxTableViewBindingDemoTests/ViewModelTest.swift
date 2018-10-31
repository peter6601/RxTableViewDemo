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
        viewModel.output.newReport.asObserver().subscribe { (report) in
            guard let aReport = report.element, let newReport = aReport else {
                return
            }
            XCTAssertEqual(newReport.userName, "user1", newReport.userName ?? "")
            XCTAssertEqual(newReport.content, "problem", newReport.content ?? "")

        }.disposed(by: disposeBag)
        let sb = PublishSubject<Void>()
        let un: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        let ct: BehaviorSubject<String?> = BehaviorSubject.init(value: nil)
        let input = ReportViewModel.Input.init(didTapButton: sb.asObservable(), userName: un.asObservable(), problem: ct.asObservable())
        viewModel.bind(with: input)
        un.onNext("user1")
        ct.onNext("problem")
        sb.onNext(())
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
