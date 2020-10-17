//
//  ViewController.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit

class MainListViewController: BaseViewController {
    
    @IBOutlet weak var mainListTableView: UITableView!
    
    var viewModel = MainListViewModel()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registCells()
        setObserveListener()
        showData()
        setRefreshController()
    }
    
    private func showData(){
        viewModel.getData(needRefresh: false)
    }
    
    private func setObserveListener(){
        viewModel.getDataObserver = { [weak self] in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.mainListTableView.reloadData()
            }
        }
    }
    
    private func registCells(){
        mainListTableView.register(UINib(nibName: "MainListTableViewCell", bundle: nil), forCellReuseIdentifier: "MainListTableViewCell")
    }
    
    private func setRefreshController(){
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        mainListTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.getData(needRefresh: true)
    }
    
    
}

//MARK:- TableView DataSource
extension MainListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainListTableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        cell.setData(productInfo: viewModel.productData[indexPath.row])
        return cell
    }
    
    
}

//MARK:- TableView Delegate
extension MainListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAlert(title: "Description", message: viewModel.productData[indexPath.row].descrip ?? "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = AnimationFactory.makeMoveUpWithBounce(rowHeight: cell.frame.height, duration: 1.0, delayFactor: 0.05)
        let animator = Animator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
}
