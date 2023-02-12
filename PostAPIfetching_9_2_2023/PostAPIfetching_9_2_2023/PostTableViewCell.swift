//
//  PostTableViewCell.swift
//  PostAPIfetching_9_2_2023
//
//  Created by Mac on 08/02/23.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var bodylbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
