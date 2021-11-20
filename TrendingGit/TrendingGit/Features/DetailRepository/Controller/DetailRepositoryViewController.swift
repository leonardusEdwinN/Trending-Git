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
    
    @IBOutlet weak var imageDetailRepo: UIImageView!
    @IBOutlet weak var labelRepoName: UILabel!
    @IBOutlet weak var labelRepoDesc: UILabel!
    @IBOutlet weak var labelFork: UILabel!
    @IBOutlet weak var labelStar: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MASUK \(repositoryViewModel?.item.name)")
        
        setUI()
    }
    
    func setUI(){
        if let imageUrl = URL(string: repositoryViewModel?.item.owner?.avatar_url ?? ""),
           let repoName = repositoryViewModel?.item.name,
           let repoDesc = repositoryViewModel?.item.description,
           let repoFork = repositoryViewModel?.item.forks_count,
           let repoStar = repositoryViewModel?.item.stargazers_count{
            
            imageDetailRepo.layer.cornerRadius = imageDetailRepo.frame.size.width / 2
            imageDetailRepo.loadImage(withUrl: imageUrl)
            labelRepoName.text = repoName
            labelRepoDesc.text = repoDesc
            labelFork.text = "Fork : \(repoFork)"
            labelStar.text = "Star : \(repoStar)"
        }
        
    }
}
