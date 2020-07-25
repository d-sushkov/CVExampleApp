//
//  ListViewController.swift
//  CVExampleApp
//
//  Created by Denis Sushkov on 17.07.2020.
//  Copyright © 2020 Denis Sushkov. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {
    
    var apiManager = APIManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let hapticGenerator = UIImpactFeedbackGenerator(style: .light)
    
    var dataFromAPI = [RepoModel]()
    var selectedCell: RepoModel?
    
    @IBOutlet weak var pullToRefreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiManager.delegate = self
        registerRepositoryCell()
        
        loadItems(from: self.context)
        hapticGenerator.prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        preserveLargeTitleSize()
    }
    
    @IBAction func pullToRefresh(_ sender: UIRefreshControl) {
        hapticGenerator.impactOccurred()
        apiManager.performRequest()
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        
        destinationVC.title = selectedCell?.repName
        destinationVC.selectedItem = selectedCell
    }
}
