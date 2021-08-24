//
//  AddOrderViewModel.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/24.
//ここでは　AddOrderViewに関するVMを作成する

import Foundation

//コーヒーの種類をAddOrderViewのセルに表示することやサイズを表示する
struct AddCoffeeOrderViewModel {
    
    var name: String?
    
    var total: Double = 0
    
    var coffeeType: [String] {
        
        return CoffeeType.allCases.map { $0.rawValue.capitalized }
        //mapを使って[CoffeeType]型全ての要素にアクセスしてrawValueを取得してcapitalizedした
    }
    
    var coffeeSize: [String] {
        
        return CoffeeSize.allCases.map { $0.rawValue.capitalized }
        
    }
    
    
}

