//
//  GamesViewCell.swift
//  PokeAPI
//
//  Created by Oscar Perez on 1/23/22.
//

import UIKit

class GamesViewCell: UITableViewCell {

    @IBOutlet weak var gamesTxt: UILabel!
    @IBOutlet weak var view: UIView!
    var games:GameIndex?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

extension GamesViewCell{
    func initializationInformation(){
        gamesTxt.text = String(games!.gameIndex) + " - " + games!.version.name.capitalizingFirstLetter()
    }
}
