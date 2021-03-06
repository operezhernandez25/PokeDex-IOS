//
//  MovesViewCell.swift
//  PokeAPI
//
//  Created by Oscar Perez on 1/23/22.
//

import UIKit

class MovesViewCell: UITableViewCell {
    @IBOutlet weak var movimientoTxt: UILabel!
    var moves:Move?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovesViewCell{
    func initializationInformation(){
        movimientoTxt.text = moves!.move.name.capitalizingFirstLetter()
    }
}
