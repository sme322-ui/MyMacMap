//
//  Goods.swift
//  GeoCoder3
//
//  Created by Sie monyan on 2022/1/29.
//

import Foundation
class Goods {
    let name: String!
    let weight: Int!
    var price: Double!
    
    init(name: String, weight: Int, price: Double) {
        self.name = name
        self.weight = weight
        self.price = price
    }
}
let goods = Goods(name: "computer", weight: 10, price: 2000.0)
var goodArr = [Goods]()
var dbPath = ""
var db: OpaquePointer?
func createData() {
    for index in 0...4 {
        let goods = Goods(name: "computer" + "\(index)", weight: index * 10, price: 20.0)
        goodArr.append(goods)
    }
}
func fetchLibraryPath() {
    if let libraryPathString = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first {
        let pathURL = URL(fileURLWithPath: libraryPathString).appendingPathComponent("goods.sqlite")
        dbPath = pathURL.path
    }
}
