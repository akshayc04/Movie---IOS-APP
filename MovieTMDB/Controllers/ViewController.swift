//
//  ViewController.swift
//  MovieTMDB
//
//  Created by Akshay on 3/12/18.
//  Copyright © 2018 Akshay. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireImage


struct cellData{
    let celltext:String?
    let imageURL:String?
    let date:String?
    let desc:String?
    let rating:Double?
    let id: Int?
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let MY_URL = "https://api.themoviedb.org/3/movie/popular?api_key=a74a409c27da701cfaeb7e4aceefa97c"
    
    let BASE_URL = "https://image.tmdb.org/t/p/w200";
    
    let res = "results"
    
   // let classdata = DataModel()
    
    var data = [cellData]()
    
    let myTableView: UITableView = UITableView()
    
    
    
    //Load Inital View
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainscreen = UIScreen.main.bounds
        let mainWidth = mainscreen.width
        let mainHeight = mainscreen.height
        
        myTableView.frame = CGRect(x: 0, y: 0, width: mainWidth, height: mainHeight)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.estimatedRowHeight = 200
        myTableView.backgroundColor = UIColor.black
        
        self.navigationItem.title = "Movies"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.yellow]
          navigationController?.navigationBar.barStyle = .blackTranslucent
        edgesForExtendedLayout = []
        getdata()
        
        view.addSubview(myTableView)
    }
    
    
    
    //TableView - NO.of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    //Table View - cellforRowAt -  send data to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell\(indexPath.row)")
        cell.layoutSubviews()
        cell.selectionStyle = .none
        
        let imageURL = "https://image.tmdb.org/t/p/w200\(data[indexPath.row].imageURL!)"
        
        Alamofire.request(imageURL).responseImage { response in
            
            if let image = response.result.value {
                cell.cImageView.image = image
            }
        }
        cell.messageView.text = data[indexPath.row].celltext
        cell.cMessage = data[indexPath.row].celltext
        
       //print( "--------" + "\(BASE_URL)" + "\(data[indexPath.row].imageURL!)" + "\(data[indexPath.row].celltext!)")
        
        return cell
    }
    
    
    
    //send data to detail view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailsViewController()
        
        detailController.imgID = data[indexPath.row].id
        
        detailController.ImgURL = data[indexPath.row].imageURL
        
        detailController.desc1 = data[indexPath.row].desc
        
        detailController.date1 = data[indexPath.row].date
            
        detailController.text = data[indexPath.row].celltext
        
        detailController.rating1 = data[indexPath.row].rating
        
        self.navigationController?.pushViewController(detailController, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        let trans = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = trans
        UIView.animate(withDuration: 0.5){
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    
    // getdata func to fetch data from URL
    func getdata()
    {
        Alamofire.request(MY_URL).responseJSON { response in
        if let json = response.result.value{
            let results = json
            let target = (results as AnyObject).object(forKey: "results") as AnyObject?
            print(target!)
        
        let dataArray : NSArray = target as! NSArray
        self.data = []
        
        for i in 0..<dataArray.count {
            self.data.append(cellData(
            celltext: (dataArray[i] as AnyObject).value(forKey: "title") as? String,
            imageURL: (dataArray[i] as AnyObject).value(forKey: "poster_path") as? String,
            date: (dataArray[i] as AnyObject).value(forKey: "release_date") as? String,
            desc: (dataArray[i] as AnyObject).value(forKey: "overview") as? String,
            rating: (dataArray[i] as AnyObject).value(forKey: "vote_average") as? Double,
            id: (dataArray[i] as AnyObject).value(forKey: "id") as? Int))
        }
        self.myTableView.reloadData()
        }
    }
  }

    
    
    
}

