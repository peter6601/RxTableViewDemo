//
//  ReportViewController.swift
//  RxTableViewBindingDemo
//
//  Created by Din Din on 2018/10/30.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


protocol ReportViewControllerDelegate: class {
    func addReport(_ report: Report)
    func editedReport(_ report: Report, row: Int)
}
class ReportViewController: UIViewController {
    

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfProblem: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBAction func send(_ sender: UIButton) {
        
        
    }
    var disposeBag: DisposeBag = DisposeBag()
    var viewModel: ReportViewModel!
    weak var delegate: ReportViewControllerDelegate? 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func dataBind(data: ReportViewModel.Dependency) {
        self.viewModel = ReportViewModel.init(with: data)
    }
    
    private func bind() {
        viewModel.input.viewDidLoad()
        let sb = sendButton.rx.tap
        let un = tfName.rx.text
        let ct = tfProblem.rx.text
        tfName.text = viewModel.dependency.report?.userName
        tfProblem.text = viewModel.dependency.report?.content
        un.asObservable().bind(to: viewModel.input.userName).disposed(by: disposeBag)
        viewModel.output.newReport.asObservable().subscribe(onNext: {  [weak self](dependency) in
            guard let report = dependency.report else {
                return
            }
            if let tag = dependency.tag {
                self?.delegate?.editedReport(report, row: tag)
            } else {
                self?.delegate?.addReport(report)
            }
            self?.navigationController?.popViewController(animated: true)
            
        }).disposed(by: disposeBag)
        viewModel.input.bindProblem(ct.asObservable())
        viewModel.input.bindUserName(un.asObservable())
        viewModel.input.bindtapButton(sb.asObservable())
    }
}
