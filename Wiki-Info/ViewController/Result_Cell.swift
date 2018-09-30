//
//  Result_Cell.swift
//  Wiki-Info
//
//  Created by Sanket on 30/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import UIKit

class Result_Cell: UITableViewCell {

    @IBOutlet weak var no_Image_Label: UILabel!
    @IBOutlet weak var result_ImgView: UIImageView!
    @IBOutlet weak var tittle_Label: UILabel!
    @IBOutlet weak var detail_Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
