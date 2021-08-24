//
//  Order.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import Foundation
//rowValueの設定をStringにした、そしてOrderはCodableに批准してるのでCoffeeTypeもOrder内でプロパティとして使うのでCodableが必要
//メニューを増やしたい場合はここに加えればいい
enum CoffeeType: String, Codable, CaseIterable {
    
    case blackCoffee
    
    case cappachino
    
    case caffeeLatte
    
    case matchaLatte
    
    case houjichaLatte
    
}
//Sizeも３つのケースなので列挙型にした
enum CoffeeSize : String, Codable, CaseIterable {
    
    case small
    case medium
    case large
}


struct Order: Codable {
    
    let name: String
    //コーヒーのメニューが決まってるので列挙型にした
    let coffeeName: CoffeeType
    
    let total: Double
    
    let size: CoffeeSize
}
