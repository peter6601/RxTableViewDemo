//
//  RegisterViewModel.swift
//  RxTableViewBindingDemo
//
//  Created by 丁暐哲 on 2018/11/4.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import Foundation

class RegisterViewModel {
    
    var list = [RegisterType]()
    
    enum RegisterType {
        case name(title: String, input: String?, info: String?)
        case password(title: String, input: String?, info: String?)
    }
    init(_ list:  [RegisterType]?) {
        guard let _list = list else {
            self.list = [RegisterType.name(title: "Name", input: nil, info: nil), RegisterType.password(title: "Password", input: nil, info: nil)]
            return
        }
        self.list = _list
    }
    
    
}
