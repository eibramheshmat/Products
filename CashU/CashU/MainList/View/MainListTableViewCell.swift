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
        // Initialization code
    }
    
    func setData(productInfo: ProductsObjects){
        productName.text = productInfo.nameEn
        if productInfo.Links.count > 0{
            guard let imageURL = productInfo.Links[0].link else {return}
            productImage.kf.setImage(with: URL(string: imageURL))
        }
    }
    
}
