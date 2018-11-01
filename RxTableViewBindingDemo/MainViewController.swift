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
            mainTableView.delegate = self
            mainTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        }
    }
    var viewModel:  MainViewModel!
    @IBAction func tappedAdd(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toReport", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        let input = MainViewModel.Input.init()
        let data = MainViewModel.Dependency.init()
        viewModel = MainViewModel(with: data)
        viewModel.bind(input)
        viewModel.output.listData.asObservable().subscribe(onNext: { [weak self] (_) in
            self?.mainTableView.reloadData()
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toReport" else {
            return 
        }
        if let vc = segue.destination as? ReportViewController {
            vc.delegate = self
            if let tag = sender as? Int {
                let report = viewModel.output.listData.value[tag]
                let model = ReportViewModel.init(with: ReportViewModel.Dependency.init(report: report, tag: tag))
                vc.viewModelBind(model)
            } else {
                vc.viewModelBind(ReportViewModel.init())

            }
        }
        
    }
}

extension  MainViewController: ReportViewControllerDelegate {
    func addReport(_ report: Report) {
        var list = viewModel.output.listData.value
        list.append(report)
        viewModel.output.listData.accept(list)
    }
    func editedReport(_ report: Report, row: Int) {
        var list = viewModel.output.listData.value
        list[row] = report
        viewModel.output.listData.accept(list)
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toReport", sender: indexPath.row)
    }
}
