//
//  Service.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import Foundation

//completionで呼ばれる時にもしエラーだった場合はこの３つのケースで呼ぶことにする
enum NetWorkError: Error {
    case decodingError
    case domainError
    case urlError
}
enum HttpMethod: String {
    
    case get = "GET"
    case post = "POST"
    
}


//データのやり取りを行うのでここでジェネリック型を使ってTが(Codableの)モデルの型の場合はurlを取得することができるようにする
//モデルをリソースとした使う
struct Resource<T: Codable> {
    
    let url: URL
   //通信に必要な取り決め した二つは初期値
    var httpMethod: HttpMethod = .get
    // データを渡すための引数
    var body: Data? = nil

}

extension Resource {
    init(url: URL) {
        self.url = url
    }
    
}


struct WebService {
    //ジェネリック関数を使って 実行するときに特殊化が必要（この場合は引数から型を決める）//completionの型にはResult<ｓ,ｆ>型を指定して成功するときはTを返して、失敗するときはNetWorkErrorを返すようにした
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T,NetWorkError>) -> Void ) {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        //json　でヘッダーが
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                
                completion(.failure(.domainError))
                return
           
            }
            
            print(data)
            //Tは引数からCodableだとわかるのでここで使う
            let result = try? JSONDecoder().decode(T.self, from: data)
        
            if let result = result {
                
               //UIで使う場合は非同期にする必要がある
                DispatchQueue.main.async {
                    
                    completion(.success(result))
                    print(result)
                }
                
            } else {
            
            completion(.failure(.decodingError))
            
            }
        
        }.resume()
        
    }
}
