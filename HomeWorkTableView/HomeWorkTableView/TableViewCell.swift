//
//  TableViewCell.swift
//  HomeWorkTableView
//
//  Created by Михаил Асмаковец on 23.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    //Устанавливаем стиль с сабтитлом
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
