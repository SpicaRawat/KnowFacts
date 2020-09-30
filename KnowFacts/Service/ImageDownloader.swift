//
//  DownloadProgressOperations.swift
//  KnowFacts
//
//  Created by Spica Rawat on 30/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import Foundation
import UIKit

class DownloadProgressOperations {
  lazy var downloadsInProgress: [IndexPath: Operation] = [:]
  lazy var downloadQueue: OperationQueue = {
    var queue = OperationQueue()
    queue.qualityOfService = .background
    return queue
  }()
    let imageCache = NSCache<NSString, UIImage>()

}

class ImageDownloader: Operation {

    let imageURL: URL

    init(_ imageURL: URL) {
      self.imageURL = imageURL
    }
    
    func downloadImage(completionHandler: @escaping ((UIImage)->())) {
        if isCancelled {
          return
        }
        
        guard let imageData = try? Data(contentsOf: imageURL) else {
                completionHandler(UIImage(named: "placeholder.png")!)
                return
        }

        if isCancelled {
          return
        }
        completionHandler(UIImage(data:imageData) ?? UIImage(named: "placeholder.png")!)
    }
}
