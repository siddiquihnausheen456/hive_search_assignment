//
//  SearchFieldTableViewcell.swift
//  hive_search_assignment
//
//  Created by Nausheen Siddiqui on 12/10/23.
//

import UIKit

class SearchFieldTableViewcell: UITableViewCell {
    @IBOutlet weak var searchField: UITextField!
    var textchangeClosure: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        searchField.tintColor = .blue
        searchField.clearButtonMode = .always

    }
    
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier:String{
        return String(describing : self)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    

    
    @IBAction func textFielddidChanged(_ sender: UITextField) {
                        self.textchangeClosure!(sender.text!)

    }

    @IBAction func textedingDidEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
