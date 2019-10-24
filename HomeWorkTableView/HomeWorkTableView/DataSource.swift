//
//  DataSource.swift
//  HomeWorkTableView
//
//  Created by Михаил Асмаковец on 23.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit
class DataSource : NSObject, UITableViewDataSource {
    
    private var sections: Array =
                            [["Sign In To Your iPhone"],
                            [],
                            ["General", "Privacy"],
                            ["Passwords & Accounts"],
                            ["Maps", "Safari", "News", "Siri","Photos", "Game Center"],
                            ["Developer"]]
   
    private var pictures: Array<[String]>
    
    private var currentSection  = 0
    private var currentElement  = 0
    
    override init() {
        pictures = Array(sections)
    }
    
    func setCurrent(_ section: Int, element: Int){
        currentSection = section
        currentElement = element
    }
    
    func getData(for indexPath: IndexPath) -> String{
        return sections [indexPath.section][indexPath.row]
    }
    
    func getCurrentData() -> String{
        return sections [currentSection][currentElement]
    }
    
    
    func setCurrentData(_ data: String){
        sections [currentSection][currentElement] = data
    }
    
    func numberOfSections(in: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.accessoryType = .disclosureIndicator

        cell.textLabel?.text = sections[indexPath.section][indexPath.row]
        
        if (indexPath.section == 0) {
            cell.detailTextLabel?.text = "Set up iCloud, the AppStore, and more"
            cell.textLabel?.textColor = UIColor.blue
        }
        
        cell.imageView?.image = UIImage(named: pictures[indexPath.section][indexPath.row] )
        
        cell.textLabel?.numberOfLines = 0
        
        print("Cell: " + cell.textLabel!.frame.size.width.description)
        
        return cell
    }
}
