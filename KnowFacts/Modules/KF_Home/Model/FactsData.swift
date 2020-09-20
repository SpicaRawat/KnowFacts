//
//  FactsData.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import UIKit

struct FactsData: Codable {
    var title: String?
    var rows: [Fact]
}
