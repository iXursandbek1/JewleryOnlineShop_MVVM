//
//  FavoriteDataManager.swift
//  JewleryOnlineShop_MVVM
//
//  Created by Xursandbek Qambaraliyev on 27/02/23.
//

import UIKit
import CoreData

class FavoriteDataManager {
    static let shared = FavoriteDataManager()
    
    //MARK: - saveToItems
    
    func saveToItems(productes: Items, complitionHandler: @escaping(Result<Bool,Error>) -> Void ) {
        
        //FIXME: Tushiunmadim  @escaping(Result<Bool,Error>
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            complitionHandler(.failure(NSError(domain: "App delegate not found", code: 123)))
            return
        }
 
    
                  
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: context)
        let favoriteObject = NSManagedObject(entity: entity!, insertInto: context)
        favoriteObject.setValue(productes.name, forKeyPath: "product")
        favoriteObject.setValue(productes.price, forKeyPath: "price")
        favoriteObject.setValue(productes.image, forKeyPath: "image")
        favoriteObject.setValue(productes.description, forKeyPath: "desc")
        favoriteObject.setValue(productes.id, forKeyPath: "id")
        
        // Error Handling
        
        do {
            
            try context.save()
            complitionHandler(.success(true))
            
        } catch {
            complitionHandler(.failure(error))
        }
    }
    
    //MARK: - fetchFavorites
    
    func fetchFavorites(complitionHandler: @escaping (Result<[NSManagedObject] , Error>) -> Void) {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            complitionHandler(.failure(NSError(domain: "App delegate not found", code: 222)))
            return
        }
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
        do {
            let fav = try managedContext.fetch(fetchRequest)
            complitionHandler(.success(fav))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK: - deleteRecords
    
    func deleteRecords(product: Int,complation: @escaping (Result<Bool, Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            complation(.failure(NSError(domain: "Appdelegate not found", code: 404, userInfo: nil)))
            return
        }
        let ctx = delegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        requestDel.returnsObjectsAsFaults = false
        do {
            let arrUsrObj = try ctx.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                if usrObj.value(forKey: "id") as! Int == product {
                        ctx.delete(usrObj) // Deleting Object
                }
            }
        } catch {
            print("Failed")
        }
        do {
            try ctx.save()
        } catch {
            print("Failed saving")
        }
    }
    
    //MARK: - checkItemExist
    func checkItemExist(id: Int) -> Bool {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
}

