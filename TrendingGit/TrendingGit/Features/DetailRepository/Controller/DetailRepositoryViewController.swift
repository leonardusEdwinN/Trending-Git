//
//  DetailRepositoryViewController.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import Foundation
import UIKit

class DetailRepositoryViewController : UIViewController{
    
    var repositoryViewModel : RepositoryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MASUK \(repositoryViewModel?.item.name)")
    }
}
