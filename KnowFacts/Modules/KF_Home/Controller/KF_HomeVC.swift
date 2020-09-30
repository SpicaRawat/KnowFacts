//
//  KF_HomeVC.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import UIKit

class KF_HomeVC: UITableViewController {

    // MARK: - CONSTANTS
    let tableRowHeight: CGFloat = 90
    let cellId = "KF_HomeCell"
    
    // MARK: - VARIABLES
    var viewModel: KF_HomeVM = {
        return KF_HomeVM()
    }()
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var isLoading = false

    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        setNavBar()
        setupTableView()
        handleCallbacks()
        startLoader()
        viewModel.loadData()
    }

    // MARK: - SET NAVIGATION BAR
    func setNavBar() {
        let navItem = self.navigationController?.navigationItem
        navItem?.setHidesBackButton(true, animated: false)
    }

    // MARK: - SET TABLE VIEW
    func setupTableView() {
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.register(KF_HomeCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = tableRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.refreshControl = refreshControl
    }

    // MARK: - REFRESH DATA
    @objc func refreshData() {
        refreshControl?.beginRefreshing()
        viewModel.loadData()
    }
    
    // MARK: - HANDLE CALLBACKS
    func handleCallbacks() {
        viewModel.handleInternetError = {[weak self] in
            DispatchQueue.main.async {
                Helpers.instance.showAlertWithTitle(messageBody: "No Internet Connection") {
                    self?.updateLoader()
                }
            }
        }
        
        viewModel.completionWithSuccess = {[weak self] in
            DispatchQueue.main.async {
                self?.updateLoader()
                self?.title = self?.viewModel.navTitle ?? ""
                self?.tableView.reloadData()
            }
        }

        viewModel.completionWithErr = {[weak self] error in
            DispatchQueue.main.async {
                Helpers.instance.showAlertWithTitle(messageBody: error.localizedDescription) {
                    self?.updateLoader()
                }
            }
        }

        viewModel.completionWithNoData = {[weak self] in
            DispatchQueue.main.async {
                Helpers.instance.showAlertWithTitle(messageBody: "No Data") {
                    self?.updateLoader()
                }
            }
        }
        
        viewModel.reloadRows = { [weak self] indexpath in
            guard let weakSelf = self else {
                return
            }
            if !weakSelf.tableView.isDragging && !weakSelf.tableView.isDecelerating {
                self?.tableView.reloadRows(at: indexpath, with: .none)
            }
        }
        
    }
    
    //MARK: - START LOADING
    func startLoader() {
        activityIndicator.frame = CGRect(x: view.frame.midX-40, y: view.frame.midY-40, width: 80, height: 80)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    // MARK: - STOP LOADING
    func updateLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.refreshControl?.endRefreshing()
        }
    }

    
}

// MARK: - TABLE EXTENSION
extension KF_HomeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.facts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! KF_HomeCell
        //bind cell data
        cell.bindData(fact: viewModel.facts[indexPath.row],cache: viewModel.downloadingOperations.imageCache)
        if !tableView.isDragging && !tableView.isDecelerating {
            viewModel.startDownload(for: viewModel.facts[indexPath.row].imageHref, at: indexPath)
        }
        return cell
    }
}

//MARK: - SCROLL VIEW EXTENSION
extension KF_HomeVC {
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.suspendAllOperations()
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      if !decelerate {
        viewModel.loadImagesForOnscreenCells(indexPathsForVisibleRows: tableView.indexPathsForVisibleRows)
        viewModel.resumeAllOperations()
      }
    }

    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        viewModel.loadImagesForOnscreenCells(indexPathsForVisibleRows: tableView.indexPathsForVisibleRows)
        viewModel.resumeAllOperations()
    }
}


