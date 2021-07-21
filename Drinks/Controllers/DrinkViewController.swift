//
//  ViewController.swift
//  Drinks
//
//  Created by Athena Fernandes Sarantôpoulos on 21/07/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class DrinkViewController: UIViewController {
    

    @IBOutlet weak var imagemDrink: UIImageView!
    @IBOutlet weak var alcolicoLbl: UILabel!
    @IBOutlet weak var nomeDrink: UILabel!
    @IBOutlet weak var ingredientesLbl: UITextView!
    

    @IBAction func newDrink(_ sender: Any) {
        consultarDrink()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        consultarDrink()
    }
    
        
    func consultarDrink() {
        DispatchQueue.main.async {
            
            Alamofire.request(Api.randomDrink, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: {
                response in
                switch response.result {
                case .success(_):
                    do {
                        let json = try JSONDecoder().decode(Drinks.self, from: response.data!)
                      
                        let drink = json.drinks[0] as Drinks.Drink
                        self.nomeDrink.text = drink.strDrink
                        self.imagemDrink.load(url: URL(string: drink.strDrinkThumb!)!)
                        self.alcolicoLbl.text = drink.strAlcoholic
                        self.ingredientesLbl.text = (drink.strIngredient1 ?? "") + "\n" + (drink.strIngredient2 ?? "") + "\n" + (drink.strIngredient3 ?? "") + "\n" + (drink.strIngredient4 ?? "") + "\n" + (drink.strIngredient5 ?? "") + "\n" + (drink.strIngredient6 ?? "") + "\n" + (drink.strIngredient7 ?? "") + "\n" + (drink.strIngredient8 ?? "") + "\n" + (drink.strIngredient11 ?? "") + "\n" + (drink.strIngredient9 ?? "") + "\n" + (drink.strIngredient10 ?? "") + "\n" + (drink.strIngredient12 ?? "") + "\n" + (drink.strIngredient13 ?? "") + "\n" + (drink.strIngredient14 ?? "") + "\n" + (drink.strIngredient15 ?? "") + "\n"
                        
                        self.ingredientesLbl.isEditable = false

                        
                    } catch {
                        print("Erro ao realizar o decode do JSON: \(error.localizedDescription)")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
    
        
}


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



