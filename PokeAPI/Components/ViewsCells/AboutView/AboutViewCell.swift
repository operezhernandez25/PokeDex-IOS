//
//  AboutViewCell.swift
//  PokeAPI
//
//  Created by Oscar Perez on 1/13/22.
//

import UIKit
import TagListView
import TagListView

class AboutViewCell: UITableViewCell {
    
    @IBOutlet weak var heightTxt: UILabel!
    @IBOutlet weak var weightTxt: UILabel!
    @IBOutlet weak var abilitiesList: TagListView!
    @IBOutlet weak var viewContainer: UIView!
    
    //Create Object to save the pokemon
    var pokemonPokedex:PokemonDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewContainer.layer.cornerRadius = 5
        viewContainer.layer.masksToBounds = true;
        // Configure the view for the selected state
    }
    
}

extension AboutViewCell{
    func initializationInformation(){
        abilitiesList.removeAllTags()
        //Filling field
        heightTxt.text = String(pokemonPokedex!.height)
        weightTxt.text = String(pokemonPokedex!.weight)
        abilitiesList.tagBackgroundColor = colorPicker(types:  pokemonPokedex!.types[0].type.name)
        abilitiesList.textFont = UIFont.systemFont(ofSize: 15.0)
        abilitiesList.textColor = UIColor(rgb: 0xFAFDFD)
        abilitiesList!.backgroundColor = .none
        abilitiesList.addTags(pokemonPokedex!.abilities.map{$0.ability.name})
        
    }
}
