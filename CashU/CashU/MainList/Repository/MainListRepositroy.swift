//
//  MainListRepositroy.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation

class MainListRepositroy {
    
    var getRemoteDataObserve: ((_ response:Response<ProductsModel>)->())?
    
    func getDataFromRemote(){
        Network.shared.request(router: Router.getProductsData, model: ProductsModel()) { (result) in
            switch result{
            case .success(let response):
                self.getRemoteDataObserve?(Response(data: response, error: nil))
            case .failure(let error):
                self.getRemoteDataObserve?(Response(data: nil, error: error.errorDescription))
            }
        }
    }
}
