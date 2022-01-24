//
//  PokemonPrincipal.swift
//  PokeAPI
//
//  Created by Oscar Perez on 12/11/21.
//

import UIKit

class PokemonPrincipal: UITableViewCell {

    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var pokemonButton: UIButton!
    
    
    var pokemonUrl:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonClick(_ sender: Any) {
        
    }
    
}
