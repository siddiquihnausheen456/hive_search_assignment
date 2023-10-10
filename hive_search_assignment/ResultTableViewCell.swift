//
//  ResultTableViewCell.swift
//  hive_search_assignment
//
//  Created by Nausheen Siddiqui on 10/10/23.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
}
