//
//  DetailsViewController.swift
//  MovieTMDB
//
//  Created by Akshay on 3/13/18.
//  Copyright © 2018 Akshay. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
import  AlamofireImage


struct collectionData {
    let colImgURL:String?
}


class DetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var coldata = [collectionData]()
    var text: String!
    var dimage: UIImage!
    var desc1 : String!
    var rating1 : Double!
    var date1: String!
    var ImgURL: String!
    var imgID: Int!
    var BaseURL:String = "https://image.tmdb.org/t/p/w300"
    var ColURL:String!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        self.view.backgroundColor = UIColor.black
        self.title = text
        
        self.colData() { () -> () in      //inorder execution
        self.setupView()
        }
    }

    
    //func to get movie posters from backdrop
    func colData(handleComplete:@escaping (()->()))
    {
        let URL = "https://api.themoviedb.org/3/movie/\(imgID!)/images?api_key=a74a409c27da701cfaeb7e4aceefa97c"
        
        Alamofire.request(URL).responseJSON { response in
            if let json = response.result.value{
                let results1 = json
                let target1 = (results1 as AnyObject).object(forKey: "backdrops") as AnyObject?
                let dataArray1 : NSArray = target1 as! NSArray
                self.coldata = []
                
                for i in 0..<dataArray1.count {
                    self.coldata.append(collectionData(
                        colImgURL: (dataArray1[i] as AnyObject).value(forKey: "file_path") as? String))
                }
                handleComplete()    //To make execution synchronous
            }
        }
    }
        

    
    func setupView() {
        
        //setup collection view
        let flowlayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect (x: 40, y: 80, width: 250, height: 200), collectionViewLayout: flowlayout)
        flowlayout.itemSize = CGSize(width: 250, height: 200)
        flowlayout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "cellid")
        self.view.addSubview(collectionView)

        // setup rating stars
        let star = CosmosView()
        star.frame = CGRect(x: 100, y: 300, width: 100, height: 30)
        star.settings.fillMode = .precise
        star.settings.updateOnTouch = false
        star.rating = rating1/2
        self.view.addSubview(star)
        
        //Setup release date
        let date2 = UILabel(frame: CGRect(x: 100, y: 340, width: 200, height: 21))
        date2.center = CGPoint(x: 160, y: 340)
        date2.textAlignment = .center
        date2.backgroundColor = UIColor.black
        date2.textColor = UIColor.yellow
        date2.text = date1
        self.view.addSubview(date2)
        
        //setup movie description
        let desc2 = UITextView()
        desc2.frame = CGRect(x: 30, y: 370, width: 250, height: 180)
        desc2.text = desc1
        desc2.font = .systemFont(ofSize: 13)
        desc2.textAlignment = .center
        desc2.textColor = UIColor.yellow
        desc2.backgroundColor = UIColor.black
        self.view.addSubview(desc2)
        
        
    }
    
    
    //returns no of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    //load data in collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mycell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! CollectionCell
        
       if(self.coldata.count > 0) {
            Alamofire.request(BaseURL + coldata[indexPath.row].colImgURL!).responseImage { response in
                if let image = response.result.value {
                   mycell.collimg.image  = image
                }
            }
       }
        return mycell
    }
    
    
}

