//
//  CellTableViewCell.swift
//  prepExam
//
//  Created by Javier Rodríguez Valentín on 11/10/2021.
//

import UIKit

class CellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellview: UIStackView!
    @IBOutlet weak var labelCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellview.backgroundColor = .lightGray
        labelCell.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
