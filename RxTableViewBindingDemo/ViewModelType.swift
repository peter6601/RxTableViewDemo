//
//  ViewModelType.swift
//  RxTableViewBindingDemo
//
//  Created by Din Din on 2018/10/30.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import Foundation


protocol ViewModelDependencyType {
    associatedtype Dependency
    var dependency: Dependency! {get set}
    init(with dependency: Dependency )
}

protocol Client: ViewModelDependencyType {
    associatedtype Client
    var client: Client {get set}
    init(client: Client) 
}

protocol ViewModelBindingType {
    associatedtype Input
    associatedtype Output
    var input: Input! { get}
    var output: Output! { get set }
}
