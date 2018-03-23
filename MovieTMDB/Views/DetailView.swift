//
//  DetailView.swift
//  MovieTMDB
//
//  Created by Akshay on 3/14/18.
//  Copyright © 2018 Akshay. All rights reserved.
//

import UIKit

class DetailView: UIView{
    
    
    var title : String!
    var image : UIImage!
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
        var dImageView: UIImageView = {
            var imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
        var dtitle: UITextView = {
            var titleLabel = UITextView()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.backgroundColor = UIColor.yellow
            titleLabel.font = UIFont.systemFont(ofSize: 20.0)
            titleLabel.textColor = UIColor.white
            print("text:\(String(describing: titleLabel.text))")
            return titleLabel
        }()


    
    func setup() {
        backgroundColor = UIColor.cyan
    
        self.addSubview(dImageView)
        self.addSubview(dtitle)
    
        dImageView.backgroundColor = UIColor.red
        dImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dImageView.topAnchor.constraint(equalTo: self.dtitle.bottomAnchor).isActive = true
        dImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true


        dtitle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        dtitle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        dtitle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        dtitle.widthAnchor.constraint(equalToConstant: 200).isActive = true
        dtitle.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
