//
//  APIManager.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    struct SpecialCharacterPreprocessor: DataPreprocessor {
        func preprocess(_ data: Data) throws -> Data {
            guard let dataString = String(data: data, encoding: .isoLatin1), let encodedData = dataString.data(using: .utf8) else {
                return data
            }
            return encodedData
        }
    }


    private class func apiService<T: Decodable>(url:String, completionHandler: @escaping((Result<T, AFError>) -> Void)) {
        
        let url = BASEURL+url
        AF.request(url).responseDecodable(of: T.self, dataPreprocessor: SpecialCharacterPreprocessor()) { (response) in
            completionHandler(response.result)
        }
    }
    
    // MARK: - API TO GET FACT FROM SERVER
    func getFactFromServer(url: String, completion: @escaping ((Result<FactsData, AFError>) -> Void)) {
        APIManager.apiService(url: url, completionHandler: completion)
    }
}
