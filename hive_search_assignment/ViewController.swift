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
        resultTableView.dataSource = self.resultViewModel
        resultTableView.delegate = self.resultViewModel
        self.resultViewModel.viewController = self
        self.resultViewModel.tableView = self.resultTableView
        
        makeAnApiCall()

    }
    
    
    func makeAnApiCall(){
        resultViewModel.callRequest(completion: {
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

