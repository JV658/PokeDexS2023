//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by Cambrian on 2023-06-05.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
