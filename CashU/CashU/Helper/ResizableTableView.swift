//
//  ResizableTableView.swift
//  Sayarti
//
//  Created by Ibram on 6/19/20.
//  Copyright © 2020 Mina Malak. All rights reserved.
//

import UIKit
class ResizableTableView: UITableView{
    
    override var contentSize: CGSize{
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
