//
//  DetailController.swift
//  PokeAPI
//
//  Created by Oscar Perez on 12/11/21.
//

import UIKit
import DropDown
import Alamofire
class DetailController: UIViewController {

    //Declarations
    @IBOutlet weak var tableDetail: UITableView!
    @IBOutlet weak var tabViews: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    let segments = ["About","Base Stats","Moves","Games"]
    
    //Variables declaration
    var url:String?
    var listData:[PokemonDetails]! = nil
    var selectionTabIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Preparing header table
        tableDetail.dataSource = self
        tableDetail.delegate = self
        tableDetail.isScrollEnabled = false
        //tableDetail.delegate = self
        tableDetail.register(UINib(nibName: "HeaderDetail", bundle: nil), forCellReuseIdentifier: "HeaderDetail")
        
        //Preparing header tabView
        tabViews.dataSource = self
        tabViews.delegate = self
        tabViews.isScrollEnabled = false
        tabViews.register(UINib(nibName: "AboutViewCell", bundle: nil), forCellReuseIdentifier: "AboutViewCell")
        tabViews.register(UINib(nibName: "StatsViewCell", bundle: nil), forCellReuseIdentifier: "StatsViewCell")
        tabViews.register(UINib(nibName: "MovesViewCell", bundle: nil), forCellReuseIdentifier: "MovesViewCell")
        tabViews.register(UINib(nibName: "GamesViewCell", bundle: nil), forCellReuseIdentifier: "GamesViewCell")
        
        
        //SegmentControl
        segmentController.removeAllSegments()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentController.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentController.setTitleTextAttributes(titleTextAttributes, for: .selected)
        for(index,value) in segments.enumerated(){
            segmentController.insertSegment(withTitle: value, at: index, animated: false)
        }
        
        segmentController.selectedSegmentIndex = 0
        
        // Do any additional setup after loading the view.
        print(url!)
        fetch([url!], of: PokemonDetails.self)
        

    }

    @IBAction func segmentValucChange(_ sender: Any) {
        selectionTabIndex = segmentController.selectedSegmentIndex
        self.tabViews.reloadData()
    }
}


//MARK: TABLE DELEGATE
extension DetailController: UITableViewDataSource,UITableViewDelegate{
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.00
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == tableDetail{
            return 1
        } else if tableView == tabViews{
            return 1
        }
        else{
            return 0
        }
    }
    
 
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        //This configuration is for both tables
        if tableView == tabViews && self.selectionTabIndex == 1{
            return self.listData[0].stats.count
        }else if tableView == tabViews && self.selectionTabIndex == 2{
            return self.listData[0].moves.count
        }else if tableView == tabViews && self.selectionTabIndex == 3{
            return self.listData[0].gameIndices.count
        } else if tableView == tabViews && self.selectionTabIndex == 0{
            return 1
        } else if tableView == tableDetail{
            return 1
        }else{
            return 0
        }
    }
        
    
public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    //tableDetail
    if tableView == tableDetail{
        let cell = tableDetail.dequeueReusableCell(withIdentifier: "HeaderDetail", for: indexPath) as? HeaderDetail
        
        //Desempaqueto la data
        if let  pokemonDetail =  listData{
            if pokemonDetail.count > 0{
                cell?.pokemonPokedex = self.listData[0]
                cell?.selectionStyle = .none
                tabViews.isScrollEnabled = false
                cell?.initializationInformation()
            }
        }
        return cell!
    }else if tableView == tabViews && selectionTabIndex == 0
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutViewCell", for: indexPath) as? AboutViewCell
        if let pokemonDetail = listData{
            if pokemonDetail.count > 0{
                cell?.pokemonPokedex = self.listData[0]
                cell?.selectionStyle = .none
                tabViews.isScrollEnabled = false
                cell?.initializationInformation()
            }
        }
        
        return cell!
    }else if tableView == tabViews && selectionTabIndex == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsViewCell", for: indexPath)as? StatsViewCell
        if let pokemonDetail = listData{
            if pokemonDetail.count > 0{
                cell?.selectionStyle = .none
                cell?.stat = self.listData[0].stats[indexPath.row]
                tabViews.isScrollEnabled = false
                cell?.initializationInformation()
            }
        }
        return cell!
    }else if tableView == tabViews && selectionTabIndex == 2{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovesViewCell", for: indexPath) as? MovesViewCell
        if let pokemonDetail = listData{
            if pokemonDetail.count > 0{
                cell?.selectionStyle = .none
                cell?.moves = self.listData[0].moves[indexPath.row]
                cell?.initializationInformation()
                tabViews.isScrollEnabled = true
            }
        }
        return cell!
    }else if tableView == tabViews && selectionTabIndex == 3{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GamesViewCell", for: indexPath) as? GamesViewCell
        if let pokemonDetail = listData{
            if pokemonDetail.count > 0{
                cell?.selectionStyle = .none
                cell?.games = self.listData[0].gameIndices[indexPath.row]
                cell?.initializationInformation()
                tabViews.isScrollEnabled = true
            }
        }
        return cell!
    }else{ // Default Result
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        return cell
    }
    
    
}
    
    
}


//MARK: FUNTIONS
extension DetailController{
    private func fetch<T: Decodable>(_ list: [String], of: T.Type) {
      var items: [T] = []
      // 2
      let fetchGroup = DispatchGroup()
      
      // 3
      list.forEach { (url) in
        // 4
        fetchGroup.enter()
        // 5
        AF.request(url).validate().responseDecodable(of: T.self) { (response) in
          if let value = response.value {
            items.append(value)
          }
          // 6
          fetchGroup.leave()
        }
      }
      
      fetchGroup.notify(queue: .main) {
          print("it")
          print(type(of: items))
          self.listData = items as? [PokemonDetails]
        self.tableDetail.reloadData()
          self.tabViews.reloadData()
      }
    }
    
}
