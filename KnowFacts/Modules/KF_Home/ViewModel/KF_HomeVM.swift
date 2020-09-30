//
//  KF_HomeVM.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class KF_HomeVM {

    // MARK: - VARIABLES
    var navTitle : String?
    var facts = [Fact]()
    var reachability = Reachability()
    var isLoading = false
    var handleInternetError: (() -> Void)?
    var completionWithSuccess: (() -> Void)?
    var completionWithErr: ((Error) -> Void)?
    var completionWithNoData: (() -> Void)?
    var apiManager = APIManager()
    let downloadingOperations = DownloadProgressOperations()
    var reloadRows: (([IndexPath]) -> Void)?
    
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
            handleInternetError?()
            return
        }
        isLoading = true

        apiManager.getFactFromServer(url: "s/2iodh4vg0eortkl/facts") {[weak self] (result: Result<FactsData, AFError>) in
            self?.isLoading = false
            switch result {
            case .success(let fact):
                self?.navTitle = fact.title ?? ""

                guard !fact.rows.isEmpty else {
                    self?.completionWithNoData?()
                    return
                }
                self?.facts = fact.rows.compactMap {
                    if $0.title != nil || $0.description != nil || $0.imageHref != nil {
                        let fact = Fact(title: $0.title, description: $0.description, imageHref: $0.imageHref)
                        return fact
                    }
                    return nil
                }
                self?.completionWithSuccess?()
            case .failure(let error):
                self?.completionWithErr?(error)
            }
        }
    }
    
    // MARK: - DOWNLOAD IMAGE
    func startDownload(for imageURLString: String?, at indexPath: IndexPath) {
        
        guard downloadingOperations.downloadsInProgress[indexPath] == nil, let imageURLString = imageURLString, let imageURL = URL(string: imageURLString), downloadingOperations.imageCache.object(forKey: imageURLString as NSString) == nil else
        {
            return
        }

        let downloader = ImageDownloader(imageURL)
        
        downloader.downloadImage { (image) in
            self.downloadingOperations.imageCache.setObject(image, forKey: imageURLString as NSString)
        }

        downloader.completionBlock = {
            if downloader.isCancelled {
              return
            }

            DispatchQueue.main.async {
              self.downloadingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.reloadRows?([indexPath])
            }
      }
      
      downloadingOperations.downloadsInProgress[indexPath] = downloader
      
      downloadingOperations.downloadQueue.addOperation(downloader)
    }
    
    // MARK: - SUSPEND DOWNLOAD IMAGE
    func suspendAllOperations() {
      downloadingOperations.downloadQueue.isSuspended = true
    }

    // MARK: - RESUME DOWNLOAD IMAGE
    func resumeAllOperations() {
      downloadingOperations.downloadQueue.isSuspended = false
    }

    // MARK: - DOWNLOAD IMAGE FOR VISIBLE CELLS
    func loadImagesForOnscreenCells(indexPathsForVisibleRows: [IndexPath]?) {
        if let pathsArray = indexPathsForVisibleRows {
            let allPendingOperations = Set(downloadingOperations.downloadsInProgress.keys)
            var toBeCancelled = allPendingOperations
            let visiblePaths = Set(pathsArray)
            toBeCancelled.subtract(visiblePaths)

            var toBeStarted = visiblePaths
            toBeStarted.subtract(allPendingOperations)
              
            for indexPath in toBeCancelled {
              if let pendingDownload = downloadingOperations.downloadsInProgress[indexPath] {
                pendingDownload.cancel()
              }
              downloadingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            }
              
            for indexPath in toBeStarted {
              if let recordToProcess = facts[indexPath.row].imageHref {
                  startDownload(for: recordToProcess, at: indexPath)
              }
            }
        }
    }

}
