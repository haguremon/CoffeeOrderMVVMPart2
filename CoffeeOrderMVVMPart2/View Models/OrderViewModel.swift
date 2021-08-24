//
//  OrderViewModel.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/24.
//　　VMですることは全てのデータをViewに表示するようにすること

import Foundation

//２、次に　TableViewでは配列のデータが欲しいのでここでそのVMを作成する

class OrdersListViewModel {
    //OrderViewModel型の配列のプロパティを作成する
    var orderViewModels: [OrderViewModel]
    
    //[OrderViewModel]型の空を引数に初期化する
    init(){
        
        self.orderViewModels = [OrderViewModel]()
        
    }
    
}
//TableVIewに表示したいのでここで関数を作って表示させるようにする
extension OrdersListViewModel {
    
    func forRowAtindex( at index: Int ) -> OrderViewModel {
        
        return orderViewModels[index]
        
    }
   /*
     後で検索バーやセグメントコントロールなどのコントロールを追加することになった場合、

     検索バーやセグメントコントロール、その他のコントロールに対応するように変更することができる
     ↑やってみるしかないっしょ

    
    */
    
    
}







//１、最初に　一つのOrderをここで作る　Order型のプロパティを作る
struct OrderViewModel {
    
    let order: Order
}

//Order内のプロパティをここで入手する
extension OrderViewModel {
    //computed propertiesなのでvarだよ〜　orderプロパティのお陰で値をゲットシチャッテル☝️
    var name: String {
        
        return order.name
        
    }
    
    var coffeeName: String {
        
        return order.coffeeName.rawValue.capitalized //capitalizedで最初の文字を大文字にする
    }
    
    var total : Double {
        
        return order.total
    }
    
    var size : String {
        
        return order.size.rawValue.capitalized
    }
    
}
