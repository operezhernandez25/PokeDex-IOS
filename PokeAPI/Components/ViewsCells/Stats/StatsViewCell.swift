//
//  StatsViewCell.swift
//  PokeAPI
//
//  Created by Oscar Perez on 1/23/22.
//

import UIKit

class StatsViewCell: UITableViewCell {

    @IBOutlet weak var propertyTitle: UILabel!
    @IBOutlet weak var propertyValue: UILabel!
    @IBOutlet weak var propertyProgress: UIProgressView!
    
    //Create Object to save the pokemon
    var stat: Stat?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension StatsViewCell{
    func initializationInformation(){
        
        propertyProgress.progressTintColor = formatPokemonStatsColor(statFloat: Float(stat!.baseStat))
        propertyProgress.progress = Float(stat!.baseStat) / Float(100)
        
        propertyTitle.text = stat!.stat.name.capitalizingFirstLetter()
        propertyValue.text = String(stat!.baseStat)
        
    }
    
}
