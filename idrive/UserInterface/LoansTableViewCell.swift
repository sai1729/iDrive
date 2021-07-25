//
//  LoansTableViewCell.swift
//  idrive
//
//  Created by Dondeti, Sai Krishna on 23/07/21.
//

import UIKit

class LoansTableViewCell: UITableViewCell {
    //setting labels in xib
    @IBOutlet var userName: UILabel!
    @IBOutlet var userSector: UILabel!
    @IBOutlet var activityValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
