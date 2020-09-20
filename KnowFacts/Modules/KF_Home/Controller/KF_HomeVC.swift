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
        cell.bindData(fact: viewModel.facts[indexPath.row])
        return cell
    }

}


