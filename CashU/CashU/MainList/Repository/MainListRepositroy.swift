//
//  MainListRepositroy.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MainListRepositroy {
    
    var getRemoteDataObserve: ((_ response:Response<[ProductCash]>)->())?
    var products = [ProductCash]()
    
    func getDataFromRemote(needRefresh: Bool){
        if needRefresh{
            Network.shared.request(router: Router.getProductsData, model: ProductsModel()) { (result) in
                switch result{
                case .success(let response):
                    self.clearCashingData()
                    response.data.products.forEach { (ProductsObjects) in
                        if ProductsObjects.Links.count > 0 {
                            ProductsObjects.Links.forEach { (ProductLinks) in
                                if ProductLinks.linkType == "image"{
                                    self.saveCashing(id: ProductsObjects.id ?? 0, name: ProductsObjects.nameEn ?? "", image: ProductLinks.link ?? "", decrip: ProductsObjects.descriptionEn ?? "")
                                }
                            }
                        }else{
                            self.saveCashing(id: ProductsObjects.id ?? 0, name: ProductsObjects.nameEn ?? "", image: "noImage", decrip: ProductsObjects.descriptionEn ?? "")
                        }
                    }
                    self.fetchCoreData()
                    self.getRemoteDataObserve?(Response(data: self.products, error: nil))
                case .failure(let error):
                    self.getRemoteDataObserve?(Response(data: nil, error: error.errorDescription))
                }
            }
        }else{
            fetchCoreData()
            if products.count > 0 {
                getRemoteDataObserve?(Response(data: self.products, error: nil))
            }else{
                Network.shared.request(router: Router.getProductsData, model: ProductsModel()) { (result) in
                    switch result{
                    case .success(let response):
                        self.clearCashingData()
                        response.data.products.forEach { (ProductsObjects) in
                            if ProductsObjects.Links.count > 0 {
                                ProductsObjects.Links.forEach { (ProductLinks) in
                                    if ProductLinks.linkType == "image"{
                                        self.saveCashing(id: ProductsObjects.id ?? 0, name: ProductsObjects.nameEn ?? "", image: ProductLinks.link ?? "", decrip: ProductsObjects.descriptionEn ?? "")
                                    }
                                }
                            }else{
                                self.saveCashing(id: ProductsObjects.id ?? 0, name: ProductsObjects.nameEn ?? "", image: "noImage", decrip: ProductsObjects.descriptionEn ?? "")
                            }
                        }
                        self.fetchCoreData()
                        self.getRemoteDataObserve?(Response(data: self.products, error: nil))
                    case .failure(let error):
                        self.getRemoteDataObserve?(Response(data: nil, error: error.errorDescription))
                    }
                }
            }
        }
    }
    
    private func saveCashing(id: Int, name: String, image: String, decrip: String){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managmentContext = appDelegate.persistentContainer.viewContext
        let product = NSEntityDescription.insertNewObject(forEntityName: "ProductCash", into: managmentContext)
        product.setValue(id, forKey: "id")
        product.setValue(name, forKey: "name")
        product.setValue(image, forKey: "image")
        product.setValue(decrip, forKey: "descrip")
        do{
            try managmentContext.save()
        }catch let error  as NSError {
            print("couldn't save .\(error), \(error.userInfo)")
        }
        
    }
    
    private func fetchCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managmentContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCash")
        do{
            let result = try managmentContext.fetch(fetchRequest)
            self.products = result as! [ProductCash]
        }catch{
            print("faild fetching")
        }
    }
    
    private func clearCashingData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managmentContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ProductCash")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managmentContext.execute(deleteRequest)
        } catch let error as NSError {
            print("couldn't delete .\(error), \(error.userInfo)")
        }
    }
}
