//
//  KF_HomeVM.swift
//  KnowFacts
//
//  Created by Spica Rawat on 17/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import UIKit
import Alamofire

class KF_HomeVM {

    // MARK: - VARIABLES
    var navTitle : String?
    var facts = [Fact]()
    var reachability = Reachability()
    var isLoading = false
    var apiManager = APIManager()

    
    // MARK: - LOAD DATA
    func loadData() {
        guard !isLoading else {
            return
        }
        getDataFromServer()
    }

    // MARK: - GET FACTS FROM SERVER
    func getDataFromServer()
    {
        
        guard reachability.isConnectedToInternet() else {
            return
        }
        isLoading = true

        apiManager.getFactFromServer(url: "s/2iodh4vg0eortkl/facts") {[weak self] (result: Result<FactsData, AFError>) in
            self?.isLoading = false
            switch result {
            case .success(let fact):
                self?.navTitle = fact.title ?? ""

                guard !fact.rows.isEmpty else {
                    return
                }
                self?.facts = fact.rows.compactMap {
                    if $0.title != nil || $0.description != nil || $0.imageHref != nil {
                        let fact = Fact(title: $0.title, description: $0.description, imageHref: $0.imageHref)
                        return fact
                    }
                    return nil
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}
