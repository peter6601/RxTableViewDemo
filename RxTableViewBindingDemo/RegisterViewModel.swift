//
//  RegisterViewModel.swift
//  RxTableViewBindingDemo
//
//  Created by 丁暐哲 on 2018/11/4.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {
    
    var list = [RegisterType]()
    var name: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    var password: BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    var nameInfoisHidden: Driver<Bool> = Driver.just(true)
    var passwordInfoisHidden: Driver<Bool> = Driver.just(true)
    var disposeBag: DisposeBag = DisposeBag()
    
    enum RegisterType {
        case name(title: String, input: BehaviorRelay<String?>, info: String?)
        case password(title: String, input: BehaviorRelay<String?>, info: String?)
    }
    init(_ list:  [RegisterType]?) {
        guard let _list = list else {
            self.list = [RegisterType.name(title: "Name", input: name, info: "it's wrong name"), RegisterType.password(title: "Password", input: password, info: "it's wrong password")]
            return
        }
        self.list = _list

    }
    
    func viewDidLoad() {
        nameInfoisHidden = name.map { (info) -> Bool in
            return  self.isVaild(info)
        }.asDriver(onErrorJustReturn: true)
//        name.subscribe(onNext: { (info) in
//            let isHidden = self.isVaild(info)
//            self.nameInfoisHidden = Driver.just(isHidden)
//        }).disposed(by: disposeBag)
    }
    
    
    func isVaild(_ info: String?) -> Bool {
        guard let _info = info else {
            return true
        }
        guard  _info.count > 4 else {
            return false
        }
        return true
    }
    
}
