//
//  Restaurant.swift
//  GeoCoder
//
//  Created by Sie monyan on 2021/10/16.
//

import Foundation
class Restaurant{
    var name = ""
    var type=""
    var location = ""
    var image=""
    var isVisited = false

    var restaurant:Restaurant!
   
    init(name:String,type:String,location:String,image:String,isVisited:Bool){
        self.name = name  
        self.type  = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        
    }

 

    
}
