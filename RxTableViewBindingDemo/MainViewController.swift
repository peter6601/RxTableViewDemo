//
//  ViewController.swift
//  RxTableViewBindingDemo
//
//  Created by Din Din on 2018/10/30.
//  Copyright © 2018 ISunCloud. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView! {
        didSet {
            mainTableView.dataSource = self
            mainTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")

        }
    }
    var viewModel:  MainViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = MainViewModel.Input.init(viewDidLoad: self.rx.sentMessage(#selector(MainViewController.viewDidAppear(_:))).map({ _ in }))
        let data = MainViewModel.Dependency.init()
        viewModel = MainViewModel(with: data)
        viewModel.bind(input)
        
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.output.listData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell
        let data = viewModel.output.listData.value[indexPath.row]
        cell?.llName.text = data.title
        cell?.llcontent.text = data.content
        return cell!
    }
    
    
}
