//
//  ListTableViewCell.swift
//  RxStudy
//
//  Created by Min on 08/07/2019.
//  Copyright © 2019 seongmin. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var textLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ data: String) {
        self.textLbl.text = data
    }
    
}
