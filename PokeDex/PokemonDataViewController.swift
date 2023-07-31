//
//  PokemonDataViewController.swift
//  PokeDex
//
//  Created by Cambrian on 2023-05-29.
//

import UIKit
import CoreData

class PokemonDataViewController: UIViewController {

    @IBOutlet weak var isFav: UIButton!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var isDefaultLabel: UILabel!
    
    var pokeData: PokeData!
    var urlString: String!
    var container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    var pokemon: FavPokemon!
    
    @IBAction func toggleFav(_ sender: UIButton) {
        if sender.currentImage == UIImage(systemName: "star"){
            // change button image to filled start
            sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
            // change button image to yellow
            sender.tintColor = .yellow
            
            // create new instance of favPokemon entity
            let favPokemon = FavPokemon(context: container.viewContext)
            favPokemon.id = Int64(pokeData.id)
            favPokemon.name = pokeData.name
            favPokemon.weight = String(pokeData.weight)
            favPokemon.height = String(pokeData.height)
            favPokemon.imgURL = pokeData.sprites.front_default
            favPokemon.url = urlString
            // save that new entity in our CoreData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } else {
            // set star back to empty outline
            // remove favPokemon
            
            sender.setImage(UIImage(systemName: "star"), for: .normal)
            // change button image to black
            sender.tintColor = .black
            
            if let pokemon = pokemon {
                container.viewContext.delete(pokemon)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fetchRequest = NSFetchRequest<FavPokemon>(entityName: "FavPokemon")
        
        let predicate = NSPredicate(format: "url = %@", urlString)
        
        fetchRequest.predicate = predicate
        
        let pokemons = try! container.viewContext.fetch(fetchRequest)
        
        if pokemons.count > 0
           && pokemons.first!.id != 0{
            pokemon = pokemons.first!
            
            // TODO: add a nil check for pokemon.id
            // TODO: if pokemon.id is nil, we need to use webservices to fetch the rest of the data
            // TODO: otherwise load as normal
            idLabel.text = String(pokemon.id)
            nameLabel.text = pokemon.name
            weightLabel.text = pokemon.weight
            heightLabel.text = pokemon.height
            
            isFav.setImage(UIImage(systemName: "star.fill"), for: .normal)
            isFav.tintColor = .yellow
            
            if let imgURL = pokemon.imgURL {
                Task{
                    pokeImage.image = try await PokeAPI_Helper.fetchPokeImage(urlString: imgURL)
                }
            } else {
                pokeImage.image = UIImage(systemName: "person")
            }
            
        } else {
            Task{
                do{
                    pokeData = try await PokeAPI_Helper.fetchPokeData(urlString: urlString)
                    
                    idLabel.text = String(pokeData.id)
                    nameLabel.text = pokeData.name
                    weightLabel.text = String(pokeData.weight)
                    heightLabel.text = String(pokeData.height)
                    isDefaultLabel.text = String(pokeData.is_default)
                    
                    // TODO: save the information to core data if this is a favorited pokemon
                    if pokemons.count > 0 {
                        // change button image to filled start
                        isFav.setImage(UIImage(systemName: "star.fill"), for: .normal)
                        // change button image to yellow
                        isFav.tintColor = .yellow
                        
                        pokemon = pokemons.first!
                        
                        pokemon.id = Int64(pokeData.id)
                        pokemon.name = pokeData.name
                        pokemon.weight = String(pokeData.weight)
                        pokemon.height = String(pokeData.height)
                        pokemon.imgURL = pokeData.sprites.front_default
                        pokemon.url = urlString
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    }
                    
                    pokeImage.image = try await PokeAPI_Helper.fetchPokeImage(urlString: pokeData.sprites.front_default)
                    
                } catch {
                    preconditionFailure("Error: program failed with error \(error)")
                }
            }
        }
        
        
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
