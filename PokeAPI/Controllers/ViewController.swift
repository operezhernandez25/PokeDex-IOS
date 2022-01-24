//
//  ViewController.swift
//  PokeAPI
//
//  Created by Oscar Perez on 12/10/21.
//

import UIKit
import ProgressHUD
import Alamofire
import DropDown
class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableListado: UITableView!
    var items:[Displayable] = []
    let limitsArray = ["25","50","75","100"]
    var selectedRow:Displayable?
    var peticion:Bool = false
    //Save the page
    var offset:Int = 0
    var limitItem:Int = 25
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Aplicando protocolos
        tableListado.dataSource = self
        tableListado.delegate = self
        //Creamos los registros de la celda
        tableListado.register(UINib(nibName: "PokemonPrincipal", bundle: nil), forCellReuseIdentifier: "pokemonPrincipal")
        
       
        
    }

    @IBAction func buttonAction(_ sender: Any) {
        let parameters = ["limit":String(limitItem),"offset":String(offset)]
        
        fetchAPI(url:"https://pokeapi.co/api/v2/pokemon",params: parameters)

    }
    

    //MARK: Button dropDown
    @IBAction func buttonDropDown(_ sender: Any){
        dropDown.show()

    }
    
}
//MARK: Funtions
extension ViewController{
   
    func fetchAPI(url:String,params:[String: String]?){
        peticion = true
        let _ = AF.request(url,parameters: params)
            .validate()
            .responseDecodable(of: Petition.self){(reponse) in
                guard let petition = reponse.value else {return}
                //print("Prueba")
                self.items += petition.pokemons
                self.tableListado.reloadData()
                self.peticion = false
                print(params)
                
                self.offset =  self.offset + self.limitItem
            }
    }
    


  
}
// Extion to aply datasource protocol
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableListado.dequeueReusableCell(withIdentifier: "pokemonPrincipal", for: indexPath) as? PokemonPrincipal
        let row = self.items[indexPath.row]
        cell?.pokemonTitle.text = row.pokemonName
        
        cell?.pokemonUrl = row.pokemonUrl
        
        return cell!
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let lastSectionIndex = tableView.numberOfSections - 1
       let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
       if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
          // print("this is the last cell")
           let spinner = UIActivityIndicatorView(style: .large)
           spinner.startAnimating()
           spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))

           self.tableListado.tableFooterView = spinner
           self.tableListado.tableFooterView?.isHidden = false
       }
   }
}

// Table Information Delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = self.items[indexPath.row]
        //Instanciamos el servay donde iremos
        performSegue(withIdentifier: "VCDetail", sender: self)
        //print(.pokemonUrl)
    }
    
    //Apply an override in prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VCDetail"{
            if let destino = segue.destination as?
                DetailController{
                destino.url = selectedRow?.pokemonUrl
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pos = scrollView.contentOffset.y
        if pos > tableListado.contentSize.height-100 - scrollView.frame.size.height
        {
            guard !peticion else{
                return
            }
                print("Se llego al final")
                print("Nuevo OffSet"+String(offset))
            let parameters = ["limit":String(limitItem),"offset":String(self.offset)]
                
                fetchAPI(url:"https://pokeapi.co/api/v2/pokemon",params: parameters)
        }
                
        
    }
}

