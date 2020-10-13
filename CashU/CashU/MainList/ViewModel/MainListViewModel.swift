//
//  MainListViewModel.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

class MainListViewModel: BaseViewModel {
    
    var getDataObserver: (()->())?
    var repository = MainListRepositroy()
    var productData = ProductsModel(){
        didSet{
            getDataObserver?()
        }
    }
    
    func getData(){
        setObserveListener()
        repository.getDataFromRemote()
    }
    
    func setObserveListener() {
        repository.getRemoteDataObserve = { [weak self] (result) in
            if let data = result.data{
                self?.productData = data
            }
        }
    }
}
