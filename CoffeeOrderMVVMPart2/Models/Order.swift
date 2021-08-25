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

extension Order {
    //失敗可能イニシャライズでAddCoffeeOrderViewModelを引数にする
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard  let name = vm.name,
               let coffeeName = CoffeeType(rawValue: vm.selectedType!.lowercased()) ,
               let  size = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
       //ここで取得したのをエンコードする必要がある
        self.name = name
        self.coffeeName = coffeeName
        self.total = vm.total
        self.size = size

    }
    
}
