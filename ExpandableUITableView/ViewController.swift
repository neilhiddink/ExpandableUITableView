//
//  ViewController.swift
//  ExpandableUITableView
//
//  Created by Neil Hiddink on 6/19/18.
//  Copyright © 2018 Neil Hiddink. All rights reserved.
//

import UIKit

// MARK: ViewController: UIViewController

class ViewController: UIViewController {

    // MARK: Properties
    
    var tableViewData = [SectionData]()
    var initialSectionTitles = ["Section 1", "Section 2", "Section 3"]
    
    // MARK: IB Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewData = [SectionData(sectionTitle: "Section 1",
                                     isExpanded: false,
                                     containsUserSelectedValue: false,
                                     sectionOptions: ["Row Item 1",
                                                      "Row Item 2",
                                                      "Row Item 3",
                                                      "Row Item 4"]),
                         SectionData(sectionTitle: "Section 2",
                                     isExpanded: false,
                                     containsUserSelectedValue: false,
                                     sectionOptions: ["Row Item 1",
                                                      "Row Item 2",
                                                      "Row Item 3"])]
        
    }
    
    // MARK: Helper Methods
    
    private func alertUserOfMissingSelections() {
        let alert = UIAlertController(title: "Missing Details", message: "You did not make a selection for each section.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: IB Actions
    
    @IBAction func startButtonPressed(_ sender: UIBarButtonItem) {
        
        if tableViewData[0].containsUserSelectedValue == true && tableViewData[1].containsUserSelectedValue == true {
            
            if tableViewData.count > 3 || tableView.numberOfSections > 2 {
                guard tableViewData[2].containsUserSelectedValue == true else {
                    alertUserOfMissingSelections()
                    return
                }
            }
            
            guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") else { return }
            self.present(detailVC, animated: true, completion: nil)
        } else {
            alertUserOfMissingSelections()
        }
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
                case 0: // Section Header
                    if tableViewData.count > 2 {
                        tableViewData.removeLast()
                        tableView.reloadData()
                    }
                case 1: // Section 1
                    tableViewData.append(SectionData(sectionTitle: "Section 3",
                                                     isExpanded: false,
                                                     containsUserSelectedValue: false,
                                                     sectionOptions: ["100",
                                                                      "500",
                                                                      "1000",
                                                                      "Custom"]))
                    tableView.reloadData()
                case 2: // Section 2
                    tableViewData.append(SectionData(sectionTitle: "Section 3",
                                                     isExpanded: false,
                                                     containsUserSelectedValue: false,
                                                     sectionOptions: ["50",
                                                                      "250",
                                                                      "750",
                                                                      "Custom"]))
                    tableView.reloadData()
                case 3: // Section 3
                    tableViewData.append(SectionData(sectionTitle: "Section 3",
                                                     isExpanded: false,
                                                     containsUserSelectedValue: false,
                                                     sectionOptions: ["10",
                                                                      "30",
                                                                      "60",
                                                                      "Custom"]))
                    tableView.reloadData()
                case 4: // Section 4
                    if tableViewData.count > 2 {
                        tableViewData.removeLast()
                        tableView.reloadData()
                    }
                default:
                    break
            }
        }
        
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].isExpanded == true {
                tableViewData[indexPath.section].isExpanded = false
                tableViewData[indexPath.section].sectionTitle = initialSectionTitles[indexPath.section]
                tableViewData[indexPath.section].containsUserSelectedValue = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            } else {
                tableViewData[indexPath.section].isExpanded = true
                tableViewData[indexPath.section].containsUserSelectedValue = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        } else {
            tableViewData[indexPath.section].isExpanded = false
            tableViewData[indexPath.section].sectionTitle = tableViewData[indexPath.section].sectionOptions[indexPath.row - 1]
            tableViewData[indexPath.section].containsUserSelectedValue = true
            
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
    
    // Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].isExpanded == true {
            return tableViewData[section].sectionOptions.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0: // Custom Cell - Section Header
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewSectionCell") as? CustomCell else { return UITableViewCell() }
                
                cell.setSectionText(string: tableViewData[indexPath.section].sectionTitle)
                
                if tableViewData[indexPath.section].isExpanded == true {
                    cell.setSectionText(string: initialSectionTitles[indexPath.section])
                    cell.setSectionDetailText(string: "")
                } else {
                    if tableViewData[indexPath.section].containsUserSelectedValue == true {
                        cell.setSectionDetailText(string: "\(initialSectionTitles[indexPath.section]) ✓")
                    } else {
                        cell.setSectionDetailText(string: ">")
                    }
                }
                return cell
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewRowCell") as? CustomCell else { return UITableViewCell() }
                
                cell.setRowText(string: tableViewData[indexPath.section].sectionOptions[indexPath.row - 1])
                return cell
        }
        
    }
    
}
