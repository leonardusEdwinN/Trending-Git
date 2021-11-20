//
//  ListRepositoriesViewController.swift
//  TrendingGit
//
//  Created by Edwin Niwarlangga on 20/11/21.
//

import Foundation
import UIKit

class ListRepositoriesViewController : UIViewController{
    
    @IBOutlet weak var listRepositoriesCollectionView: UICollectionView!
    
    // MARK: Searh
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: Variable
    private var listRepositoriesViewModel = ListRepositoriesViewModel()
    private var selectedIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        searchTextField.delegate = self
        searchRepo(keyword: "edwin")
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: For dismiss Keyboard and Tap
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ListRepositoriesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
    func registerCell(){
        listRepositoriesCollectionView.register(UINib.init(nibName: "ListRepositoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listRepositoriesCollectionViewCell")
        listRepositoriesCollectionView.delegate = self
        listRepositoriesCollectionView.dataSource = self
    }
    
    // MARK: Searching REPO
    func searchRepo(keyword search : String){
        listRepositoriesViewModel.searchRepositories(for: search) { RepositoryViewModel in
            DispatchQueue.main.async {
                self.listRepositoriesCollectionView.reloadData()
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetailVC"{
            if let destVC = segue.destination as? DetailRepositoryViewController {
                
                let repositoryVM = listRepositoriesViewModel.modelAt(self.selectedIndex)
                destVC.repositoryViewModel = repositoryVM
            }
        }
    }
}

// MARK: Collectionview
extension ListRepositoriesViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRepositoriesViewModel.numberOfRows(section)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listRepositoriesCollectionViewCell", for: indexPath)  as! ListRepositoriesCollectionViewCell
        
        
        let repositoryVM = listRepositoriesViewModel.modelAt(indexPath.row)
        if let fork = repositoryVM.item.forks_count, let star = repositoryVM.item.stargazers_count{
            cell.setUI(image: "", title: repositoryVM.item.name ?? "Repository Name", desc: "Fork : \(fork), Star : \(star)")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "segueToDetailVC", sender: self)
        
    }
    
    
}

// MARK: Collection view delegate Layout
extension ListRepositoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var widthCell : CGSize = CGSize(width: 100, height: 100)
        
        if collectionView == self.listRepositoriesCollectionView{
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 20
            layout.invalidateLayout()
            
            widthCell =  CGSize(width: (self.listRepositoriesCollectionView.frame.width - 60) / 2 , height: 200) // Set your item size here
        }else{
            widthCell =  CGSize(width: 125 , height:150)
        }
        
        return widthCell
    }
}

// MARK: Textfield delegate
extension ListRepositoriesViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // User finished typing (hit return): hide the keyboard.
        
        if textField == searchTextField {
            if let searchKeyword = textField.text{
                
                searchTextField.resignFirstResponder()
                searchRepo(keyword: searchKeyword)
            }
            
            return false
        }
        return true
        
        
    }
}
