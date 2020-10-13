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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registCells()
        setObserveListener()
        viewModel.getData()
    }
    
    private func setObserveListener(){
        viewModel.getDataObserver = { [weak self] in
            DispatchQueue.main.async {
                self?.mainListTableView.reloadData()
            }
        }
    }

    private func registCells(){
        mainListTableView.register(UINib(nibName: "MainListTableViewCell", bundle: nil), forCellReuseIdentifier: "MainListTableViewCell")
    }

}

//MARK:- TableView DataSource
extension MainListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productData.data.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainListTableView.dequeueReusableCell(withIdentifier: "MainListTableViewCell", for: indexPath) as! MainListTableViewCell
        cell.setData(productInfo: viewModel.productData.data.products[indexPath.row])
        return cell
    }
    
    
}

//MARK:- TableView Delegate
extension MainListViewController: UITableViewDelegate{
    
}
