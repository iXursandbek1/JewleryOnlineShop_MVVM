//
//  LikedViewController.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 09/02/23.
//

import UIKit
import SnapKit
import CoreData

class LikedViewController: UIViewController {
    
    let tableView = UITableView()
    var products : [String] = []
    var itmes    : [NSManagedObject] = []
    
    private var models = [Product]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        initView()
        getAllItems()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
        
        do {
            itmes = try managedContext.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        self.tableView.reloadData()
        
    }
    
    func initView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 120
        tableView.register(LikedControllerTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func getAllItems() {
        
        do {
            models =  try context.fetch(Product.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            
        }
    }
    
    func deleteitem(item: Product){
        context.delete(item)
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
}

extension LikedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itmes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = itmes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LikedControllerTableViewCell
        
        cell.productName.text = product.value(forKeyPath: "product") as? String
        cell.productPrice.text = product.value(forKeyPath: "price") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let item = models[indexPath.row]
            if editingStyle == .delete {
                itmes.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .middle)
                tableView.endUpdates()
                deleteitem(item: item)
            }
        }
    
    
}
