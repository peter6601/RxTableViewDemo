//
//  InputTextFieldTableViewCell.swift
//  RxTableViewBindingDemo
//
//  Created by 丁暐哲 on 2018/11/3.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import UIKit

class InputTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var llTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var llInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
