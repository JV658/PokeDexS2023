//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by Cambrian on 2023-06-05.
//

import UIKit
import CoreData

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var isfavImage: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    
    var urlString: String!
    var favPokemon: FavPokemon?
    var container: NSPersistentContainer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(toggleFav(_:)))
        longPress.minimumPressDuration = 1.5
        longPress.delaysTouchesBegan = true
        addGestureRecognizer(longPress)
    }
    
    @objc func toggleFav(_ gestureRecognizer: UIGestureRecognizer){
        
        /** FIX
            long press is a continues recognizer so it will fire this mehtod many time. to account for this we need to check if the gesture began, if it did not we need to quit this method so it doesn't get called twice
         */
        if gestureRecognizer.state != .began { return }
        
        if let pokemon = favPokemon {
            container.viewContext.delete(pokemon)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            isfavImage.alpha = 0
        } else {
            
            let favPokemon = FavPokemon(context: container.viewContext)
            favPokemon.name = pokeNameLabel.text!
            favPokemon.url = urlString
            // save that new entity in our CoreData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            isfavImage.alpha = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
