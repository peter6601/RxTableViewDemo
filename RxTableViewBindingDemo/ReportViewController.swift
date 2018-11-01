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
    
    @IBOutlet weak var ttName: UITextField!
    @IBOutlet weak var ttContent: UITextField!
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
    
    func viewModelBind(_ viewModel: ReportViewModel) {
        self.viewModel = viewModel
    }
    
    private func bind() {
        viewModel.input.viewDidLoad()
        let sb = sendButton.rx.tap
        let un = ttName.rx.text
        let ct = ttContent.rx.text
        
        let output = ReportViewModel.Output.init(userName: un, problem: ct)
        viewModel.bindOutput(with: output)
        
        let input = ReportViewModel.Input.init(didTapButton: sb.asObservable(), userName: un.asObservable(), problem: ct.asObservable())
        viewModel.bind(with: input)
        
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
    }
}
