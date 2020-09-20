//
//  Reachability.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
class Reachability {
    func isConnectedToInternet() -> Bool {
        guard let manager = NetworkReachabilityManager() else {
            return false
        }
        return manager.isReachable
    }
}
