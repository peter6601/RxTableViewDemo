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
    var nameInfoisHidden: Observable<Bool> = Observable.just(true)
    var passwordInfoisHidden: Observable<Bool> = Observable.just(true)

    enum RegisterType {
        case name(title: String, input: BehaviorRelay<String?>, info: String?)
        case password(title: String, input: BehaviorRelay<String?>, info: String?)
    }
    init(_ list:  [RegisterType]?) {
        guard let _list = list else {
            self.list = [RegisterType.name(title: "Name", input: name, info: nil), RegisterType.password(title: "Password", input: password, info: nil)]
            return
        }
        self.list = _list
    }
    
    func bindtapButton(_ didTapButton: Driver<Void>) {
        didTapButton.drive(onNext: { (_) in
            
        })
    }
    
    func checkbind(_ name: BehaviorRelay<String?>) {
        name.subscribe(onNext: { (info) in
            if let _info = info, _info.count <= 5 {
             self.nameInfoisHidden = Observable.just(false)
            }
        })
    }
    
    
}
