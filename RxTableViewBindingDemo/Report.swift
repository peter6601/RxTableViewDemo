//
//  Report.swift
//  RxTableViewBindingDemo
//
//  Created by Din Din on 2018/10/30.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import Foundation

struct Report:Codable {
    let title:String?
    let content:String?
    let userName:String?
    let printScreen:URL?
    private enum CodingKeys:String,CodingKey {
        case title
        case content
        case userName
        case printScreen
    }
    init(title:String?, content:String?,userName:String, printScreen:URL? ) {
        self.title = title
        self.content = content
        self.userName = userName
        self.printScreen = printScreen
        
    }
}
extension Report {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try? container.decode(String.self, forKey: .title)
        content = try? container.decode(String.self, forKey: .content)
        userName = try? container.decode(String.self, forKey: .userName)
        printScreen = try? container.decode(URL.self, forKey: .printScreen)
    }
}
