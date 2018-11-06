//
//  RegisterViewController.swift
//  RxTableViewBindingDemo
//
//  Created by 丁暐哲 on 2018/11/4.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.dataSource = self
            mainTableView.register(UINib(nibName: "InputTextFieldTableViewCell", bundle: nil), forCellReuseIdentifier:"InputTextFieldTableViewCell")
        }
    }
    var viewModel: RegisterViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bindViewModel(list: nil)  
        self.btnRegister.addTarget(self, action: #selector(tap), for: .touchUpInside)
//        self.viewModel.bindtapButton(self.btnRegister.rx.tap.asDriver())

    }
    
    @objc func tap() {
        
    }
    
    
    func bindViewModel(list: [RegisterViewModel.RegisterType]?) {
        self.viewModel = RegisterViewModel(list)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension RegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType =  viewModel.list[indexPath.row]
        switch cellType {
            
        case .name(let title, let input, let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextFieldTableViewCell", for: indexPath) as?  InputTextFieldTableViewCell
            cell?.llTitle.text = title
            cell?.llInfo.text = info
            cell?.tfInput.rx.text.asDriver().drive(input).disposed(by: disposeBag)
            let a = cell?.llInfo.rx.isHidden
            
            return cell!

        case .password(let title, let input, let info):
            let cell = tableView.dequeueReusableCell(withIdentifier: "InputTextFieldTableViewCell", for: indexPath) as?  InputTextFieldTableViewCell
            cell?.llTitle.text = title
            cell?.llInfo.text = info
            cell?.tfInput.rx.text.asDriver().drive(input).disposed(by: disposeBag)
            return cell!

        }
    }
    
    
}
