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
    
    // function updateUI - Update city name on UITableViewCell
    /// parameters
    //  city - String
    func updateUI(city: String) {
        self.labelCity.text = city
        self.selectionStyle = .none
    }
}
