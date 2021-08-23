//
//  Order.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import Foundation
//rowValueの設定をStringにした、そしてOrderはCodableに批准してるのでCoffeeTypeもOrder内でプロパティとして使うのでCodableが必要
enum CoffeeType: String, Codable {
    
    case BlackCoffee
    
    case CafeLatte
    
    case MatchaLatte
    
    case HoujichaLatte
    
}
enum Size : String, Codable {
    
    case Small
    case Mideum
    case Large
}


struct Order: Codable {
    
    let name: String
    let email: String
    //コーヒーのメニューが4種類のために列挙型にした
    let type: CoffeeType
    
    let size: Size
}
