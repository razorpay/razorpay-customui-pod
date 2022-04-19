//
//  MenuItemCell.swift
//  SampleApp-CustomUI
//
//  Created by Ramprasad A on 20/08/21.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 10
    }
    
    func setData(model: PayloadModel) {
        self.lblTitle.text = model.title
        self.accessibilityIdentifier = self.lblTitle.text
    }
}
