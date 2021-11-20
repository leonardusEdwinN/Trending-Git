//
//  ListRepositoriesCollectionViewCell.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import UIKit

class ListRepositoriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewOuter.layer.cornerRadius = 20
        // Initialization code
    }
    
    func setUI(image: String, title: String, desc: String){
        labelName.text = title
        labelDesc.text = desc
    }

}
