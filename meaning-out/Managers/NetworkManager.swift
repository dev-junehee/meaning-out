//
//  NetworkManager.swift
//  meaning-out
//
//  Created by junehee on 6/22/24.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func getShopping(
        query: String,
        start: Int,
        sort: String,
        completionHandler: @escaping (SearchResult) -> Void
    ) {
        let headers: HTTPHeaders = [
            API.Shopping.ID_KEY_NAME: API.Shopping.ID_KEY,
            API.Shopping.SECRET_KEY_NAME: API.Shopping.SECRET_KEY
        ]
        
        let URL = "\(API.Shopping.URL)query=\(query)&start=\(start)&sort=\(sort)"

        AF.request(URL, method: .get, headers: headers)
            .responseDecodable(of: SearchResult.self) { res in
            switch res.result {
            case .success(let value):
                completionHandler(value)
            case .failure(let error):
                print(#function, error)
            }
        }
    }
    
}
