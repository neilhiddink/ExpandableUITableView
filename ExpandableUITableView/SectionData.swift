//
//  SectionData.swift
//  ExpandableUITableView
//
//  Created by Neil Hiddink on 6/19/18.
//  Copyright © 2018 Neil Hiddink. All rights reserved.
//

import Foundation

struct SectionData {
    
    var sectionTitle: String
    var isExpanded: Bool
    var containsUserSelectedValue: Bool
    var sectionOptions: [String]
    
    init(sectionTitle: String, isExpanded: Bool, containsUserSelectedValue: Bool, sectionOptions: [String]) {
        self.sectionTitle = sectionTitle
        self.isExpanded = isExpanded
        self.containsUserSelectedValue = containsUserSelectedValue
        self.sectionOptions = sectionOptions
    }
    
}
