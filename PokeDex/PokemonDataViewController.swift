//
//  PokemonDataViewController.swift
//  PokeDex
//
//  Created by Cambrian on 2023-05-29.
//

import UIKit

class PokemonDataViewController: UIViewController {

    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var isDefaultLabel: UILabel!
    
    var pokeData: PokeData!
    var urlString: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Task{
            do{
                pokeData = try await PokeAPI_Helper.fetchPokeData(urlString: urlString)
                
                idLabel.text = String(pokeData.id)
                nameLabel.text = pokeData.name
                weightLabel.text = String(pokeData.weight)
                heightLabel.text = String(pokeData.height)
                isDefaultLabel.text = String(pokeData.is_default)
                
                pokeImage.image = try await PokeAPI_Helper.fetchPokeImage(urlString: pokeData.sprites.front_default)
                
            } catch {
                preconditionFailure("Error: program failed with error \(error)")
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
