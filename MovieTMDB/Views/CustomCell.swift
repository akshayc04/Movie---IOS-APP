//
//  CustomCell.swift
//  MovieTMDB
//
//  Created by Akshay on 3/12/18.
//  Copyright © 2018 Akshay. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

class CustomCell: UITableViewCell{
    
    var cMessage: String?
    var cImage: UIImage?
    
    
    var messageView:UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 18)
        textView.textAlignment = .center
        textView.numberOfLines = 2
        textView.backgroundColor = UIColor.black
        textView.textColor = UIColor.white
        return textView
    }()
    
    
    var cImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.addSubview(messageView)
        self.addSubview(cImageView)
      
        
        cImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        cImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.leftAnchor.constraint(equalTo: self.cImageView.rightAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let message = cMessage {
            messageView.text = message
            messageView.textColor = UIColor.yellow
            
        }
        
        if let image = cImage {
            cImageView.image = image
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
