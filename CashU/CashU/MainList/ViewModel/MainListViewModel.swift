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
    var productData = [ProductCash](){
        didSet{
            getDataObserver?()
        }
    }
    
    func getData(needRefresh: Bool){
        setObserveListener()
        repository.getDataFromRemote(needRefresh: needRefresh)
    }
    
    private func setObserveListener() {
        repository.getRemoteDataObserve = { [weak self] (result) in
            if let data = result.data{
                self?.productData = data
            }
        }
    }
}
