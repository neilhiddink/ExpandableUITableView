//
//  CustomCell.swift
//  ExpandableUITableView
//
//  Created by Neil Hiddink on 6/19/18.
//  Copyright © 2018 Neil Hiddink. All rights reserved.
//

import UIKit

// MARK: CustomCell: UITableViewCell

class CustomCell: UITableViewCell {
    
    // MARK: IB Outlets
    
    @IBOutlet weak var sectionTextLabel: UILabel!
    @IBOutlet weak var sectionDetailTextLabel: UILabel!
    @IBOutlet weak var rowTextLabel: UILabel!
        
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    //MARK: Helper Methods
    
    func setSectionText(string: String) {
        sectionTextLabel.text = string
    }
    
    func setSectionDetailText(string: String) {
        sectionDetailTextLabel.text = string
    }
    
    func setRowText(string: String) {
        rowTextLabel.text = string
    }
}
