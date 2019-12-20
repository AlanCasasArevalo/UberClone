//
//  DriverViewCell.swift
//  UberClone
//
//  Created by Alan Casas on 19/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

class DriverViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setModel(model: DriverViewCellModel) {
        emailLabel.text = model.emailLabelText
        distanceLabel.text = model.distanceLabelText
    }
    
}

class DriverViewCellModel {
    
    var emailLabelText: String?
    var distanceLabelText: String?
    var identifier: String?
    
    init(emailLabelText: String, distanceLabelText: String, identifier: String?) {
        self.emailLabelText = emailLabelText
        self.distanceLabelText = distanceLabelText
        self.identifier = identifier
    }
    
}
