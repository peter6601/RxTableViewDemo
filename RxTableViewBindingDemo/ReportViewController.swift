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
        let sb = sendButton.rx.tap.asObservable()
        let un = ttName.rx.text.asObservable()
        let ct = ttContent.rx.text.asObservable()
        
        let input = ReportViewModel.Input.init(didTapButton: sb, userName: un, problem: ct)
        viewModel.bind(with: input)
        viewModel.output.newReport.asObservable().subscribe { [weak self](newReport) in
            guard let  new = newReport.element, let newOne = new else {
                return 
            }
            self?.delegate?.addReport(newOne)
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
     
    }
    


}
