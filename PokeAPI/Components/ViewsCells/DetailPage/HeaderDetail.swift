//
//  HeaderDetail.swift
//  PokeAPI
//
//  Created by Oscar Perez on 12/15/21.
//

import UIKit
import TagListView

class HeaderDetail: UITableViewCell {

    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokeDexNumber: UILabel!
    @IBOutlet weak var typesTagList: TagListView!
    
    //Create Object to save the pokemon
    var pokemonPokedex:PokemonDetails?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        typesTagList.delegate = self
        imagePokemon.layer.cornerRadius = 3
       // cell?.backgroundColor = UIColor(rgb: 0x48D0AF)
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HeaderDetail{
    func initializationInformation(){
        
        pokemonName.text = pokemonPokedex!.name
        pokeDexNumber.text = formatPokedexIndex(pokedexIndex: pokemonPokedex!.id)
        imagePokemon.load(url: URL(string: pokemonPokedex!.sprites.frontDefault)!)
        
        //tagList
        typesTagList.tagBackgroundColor = colorPicker(types:  pokemonPokedex!.types[0].type.name)
        typesTagList.textFont = UIFont.systemFont(ofSize: 15.0)
        typesTagList.textColor = UIColor(rgb: 0xFAFDFD)
        typesTagList!.backgroundColor = .none
        typesTagList.addTags(pokemonPokedex!.types.map{ $0.type.name})
    }
}

extension HeaderDetail: TagListViewDelegate{
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print(title)
    }
}
