//
//  Service.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import Foundation
//データのやり取りを行うのでここでジェネリック型を使ってTが(Codableの)モデルの型の場合はurlを取得することができるようにする
struct Resource<T: Codable> {
    
    let url: URL

}
//completionで呼ばれる時にもしエラーだった場合はこの３つのケースで呼ぶことにする
enum NetWorkError: Error {
    case decodingError
    case domainError
    case urlError
}

struct WebService {
    //ジェネリック関数を使って 実行するときに特殊化が必要（この場合は引数から型を決める）//completionの型にはResult<ｓ,ｆ>型を指定して成功するときはTを返して、失敗するときはNetWorkErrorを返すようにした
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T,NetWorkError>) -> Void ) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            guard let data = data , error == nil else {
                completion(.failure(.domainError))
                return
            }
            //Tは引数からCodableだとわかるのでここで使う
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                
               //UIで使う場合は非同期にする必要がある
                DispatchQueue.main.async {
                    
                    completion(.success(result))

                }
                
            }
            
            completion(.failure(.decodingError))
        
        }.resume()
        
    }
}
