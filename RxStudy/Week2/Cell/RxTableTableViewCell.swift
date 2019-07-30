//
//  RxTableTableViewCell.swift
//  RxStudy
//
//  Created by Min on 30/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit

class RxTableTableViewCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier: String = "RxTableTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
