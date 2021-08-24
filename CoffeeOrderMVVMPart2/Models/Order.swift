//
//  Order.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import Foundation
//rowValueの設定をStringにした、そしてOrderはCodableに批准してるのでCoffeeTypeもOrder内でプロパティとして使うのでCodableが必要

enum CoffeeType: String, Codable {
    
    case blackCoffee
    
    case cafeLatte
    
    case matchaLatte
    
    case houjichaLatte
    
}
//Sizeも３つのケースなので列挙型にした
enum CoffeeSize : String, Codable {
    
    case small
    case mideum
    case large
}

struct Order: Codable {
    
    let name: String
    //コーヒーのメニューが4種類のために列挙型にした
    let coffeeName: CoffeeType
    
    let total: Double
    
    let size: CoffeeSize
}
