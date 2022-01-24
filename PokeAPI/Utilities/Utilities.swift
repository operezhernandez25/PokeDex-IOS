//
//  Utilities.swift
//  PokeAPI
//
//  Created by Oscar Perez on 12/16/21.
//

import Foundation
import UIKit
import TagListView


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

func colorPicker(types:String)-> UIColor{


    return UIColor(rgb: colours[types]!)
}

//MARK: Function to format PokedexIndex
func formatPokedexIndex(pokedexIndex:Int) -> String{
    if(pokedexIndex < 10){
        return "#00" + String(pokedexIndex)
    }
    else if(pokedexIndex < 100){
        return "#0" + String(pokedexIndex)
    }
    else{
        return "#" + String(pokedexIndex)
    }
}

//MARK: Function to format pokemon stats
func formatPokemonStatsColor(statFloat:Float)->UIColor{
    if statFloat <= 69{
        return UIColor(ciColor: .red)
    }else if statFloat > 70 && statFloat < 99{
        return UIColor(ciColor: .yellow)
    }else{
        return UIColor(ciColor: .green)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

var colours = [
    "normal": 0xA8A77A,
    "fire": 0xEE8130,
    "water": 0x6390F0,
    "electric": 0xF7D02C,
    "grass": 0x7AC74C,
    "ice": 0x96D9D6,
    "fighting": 0xC22E28,
    "poison": 0xA33EA1,
    "ground": 0xE2BF65,
    "flying": 0xA98FF3,
    "psychic": 0xF95587,
    "bug": 0xA6B91A,
    "rock": 0xB6A136,
    "ghost": 0x735797,
    "dragon": 0x6F35FC,
    "dark": 0x705746,
    "steel": 0xB7B7CE,
    "fairy": 0xD685AD,
]

/// An image view that computes its intrinsic height from its width while preserving aspect ratio
// Based on https://gist.github.com/marcc-orange/e309d86275e301466d1eecc8e400ad00
public class DerivedHeightImageView: UIImageView {

    public override var intrinsicContentSize: CGSize {
        previousLayoutWidth = bounds.width

        guard let image = self.image else {
            return super.intrinsicContentSize
        }

        return CGSize(
            width: bounds.width,
            height: bounds.width / image.size.aspectRatio
        )
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if previousLayoutWidth != bounds.width {
            invalidateIntrinsicContentSize()
        }
    }

    // Track the width that the intrinsic size was computed for,
    // to invalidate the intrinsic size when needed
    private var previousLayoutWidth: CGFloat = 0
}

extension CGSize {
    public var aspectRatio: CGFloat {
        return width / height
    }
}
