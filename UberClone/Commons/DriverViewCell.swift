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
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setModel(model: DriverViewCellModel) {
        emailLabel.text = model.emailLabelText
        latitudeLabel.text = "\(model.latitudeLabelText ?? 0.0)"
        longitudeLabel.text = "\(model.longitudeLabelText ?? 0.0)"
    }
    
}

class DriverViewCellModel {
    
    var emailLabelText: String?
    var latitudeLabelText: Double?
    var longitudeLabelText: Double?
    var identifier: String?
    
    init(emailLabelText: String, latitudeLabelText: Double, longitudeLabelText: Double, identifier: String?) {
        self.emailLabelText = emailLabelText
        self.latitudeLabelText = latitudeLabelText
        self.longitudeLabelText = longitudeLabelText
        self.identifier = identifier
    }
    
}
