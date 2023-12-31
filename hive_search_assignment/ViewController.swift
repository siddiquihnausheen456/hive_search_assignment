//
//  ViewController.swift
//  hive_search_assignment
//
//  Created by Nausheen Siddiqui on 10/10/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultTableView: UITableView!
    
    var resultViewModel : ResultviewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("check item")
        self.resultViewModel = ResultviewModel()
        resultTableView.register(ResultTableViewCell.nib, forCellReuseIdentifier: ResultTableViewCell.identifier)
        resultTableView.register(SearchFieldTableViewcell.nib, forCellReuseIdentifier: SearchFieldTableViewcell.identifier)
        resultTableView.dataSource = self.resultViewModel
        resultTableView.delegate = self.resultViewModel
        self.resultViewModel.viewController = self
        self.resultViewModel.tableView = self.resultTableView
        
        self.navigationController?.navigationBar.topItem?.title = "Search"
        self.navigationController?.navigationBar.backgroundColor = .systemBlue
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    func makeAnApiCall(){
        resultViewModel.callRequest(searchString: "",completion: {
            result in
            if result{
                DispatchQueue.main.async {
                    self.resultTableView.reloadData()
                    print("check data--->", result)
                }
            }
        })
    }


}

