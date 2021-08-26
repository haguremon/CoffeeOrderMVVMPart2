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
    
    
    case cappachino
    
    case latte
    
    case espressino
    
    case cortado
   
    case caffeeLatte
    
  
    
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
    //エンコードするための処理
    //Resource<[Order]>型で返すstaticプロパティを作成
    static var all: Resource<[Order]> = {
        
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect ")
        }
        
        return Resource<[Order]>(url: url)
        
    }()
    
    
    
    static func create(vm: AddCoffeeOrderViewModel) -> Resource<Order?> {
        //ここでの目的はResource<Order?>を返すこと
        
        //１、AddCoffeeOrderViewModel型を引数にして
        let order = Order(vm)
       
        //2, URL取得
        guard let url = URL(string: "https://island-bramble.glitch.me/orders") else {
            fatalError("URL is incorrect ")
        }
        //swift型のデータが入ってるのをエンコードする
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("ppppppppp")
        }
        print(data)
        
        //http
        //ここでResource<Order?>を生成して　送信で使う取り決めなどをする
        var resource = Resource<Order?>(url: url)
        //通信の取り決め
        resource.httpMethod = HttpMethod.post
        //データを保持
        resource.body = data
        
        return resource
    }
    
}

extension Order {
    //失敗可能イニシャライズでAddCoffeeOrderViewModelを引数にする
    init?(_ vm: AddCoffeeOrderViewModel) {
        
        guard  let name = vm.name,
               let total = vm.total,
               let coffeeName = CoffeeType(rawValue: vm.selectedType!.lowercased()) ,
               let  size = CoffeeSize(rawValue: vm.selectedSize!.lowercased()) else {
            return nil
        }
       //ここで取得したのをエンコードする必要がある
        self.name = name
        self.coffeeName = coffeeName
        self.total = total
        self.size = size

    }
    
}
