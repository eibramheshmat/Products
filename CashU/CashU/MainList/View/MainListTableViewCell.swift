//
//  MainListTableViewCell.swift
//  CashU
//
//  Created by Ibram on 10/13/20.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit
import Kingfisher

class MainListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(productInfo: ProductCash){
        productName.text = productInfo.name
        let imageURL = productInfo.image?.isEmpty ?? true ? "" : productInfo.image
        if imageURL == "noImage" {
            productImage.image = UIImage(named: "nodata")
        }else{
            productImage.kf.setImage(with: URL(string: imageURL ?? ""))
        }
    }
    
}
