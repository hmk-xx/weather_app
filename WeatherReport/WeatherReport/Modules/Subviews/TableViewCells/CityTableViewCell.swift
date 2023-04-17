//
//  CityTableViewCell.swift
//  WeatherReport
//
//  Created by Harish Kumar on 15/04/23.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var labelCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(location: String) {
        self.labelCity.text = location
        self.selectionStyle = .none
    }
}
