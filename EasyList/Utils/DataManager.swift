//
//  DataManager.swift
//  EasyList
//
//  Created by Student20 on 24/08/2024.
//

import Foundation
import FirebaseDatabase

class DataManager {
    static let shared = DataManager()
    private let listsKey = ConstantsUserDefaults.listsKey
    
    var ref: DatabaseReference!
    
    private init() {}
    
    func saveLists(_ lists: [List]) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(lists)
            print("Saving data: \(data)")
            UserDefaults.standard.set(data, forKey: listsKey)
        } catch {
            print("Failed to encode lists: \(error)")
        } // end do-catch
    } // end saveLists
    
    func addListToDB(list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        ref = Database.database().reference()
        guard let currentUser = UserManager.shared.currentUser else { return }
        let listRef = self.ref.child("users").child(currentUser.uid).child("lists").child(list.listId)
        
        do {
            let listData = try JSONEncoder().encode(list)
            let listJSON = try JSONSerialization.jsonObject(with: listData, options: [])
            listRef.setValue(listJSON) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            } // end setValue
        } catch let error {
            completion(.failure(error))
        } // end do-catch
    } // end addList
    
    func addListItemToDB(listItem: ListItem, list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else { return }
        ref = Database.database().reference()
        let listItemRef = self.ref.child("users").child(currentUser.uid).child("lists").child(list.listId).child("items").child(listItem.listItemId)
        
        do {
            let listItemData = try JSONEncoder().encode(listItem)
            let listItemJSON = try JSONSerialization.jsonObject(with: listItemData, options: [])
            listItemRef.setValue(listItemJSON) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            } // end setValue
        } catch let error {
            completion(.failure(error))
        } // end do-catch
    } // addListItem

    func updateListItem(listItem: ListItem, list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else { return }
        ref = Database.database().reference()
        let listItemRef = self.ref.child("users").child(currentUser.uid).child("lists").child(list.listId).child("items").child(listItem.listItemId)
        
        let listItemCompletedKey = ListItem.CodingKeys.completed.rawValue
        let childUpdate = ["\(listItemCompletedKey)" : listItem.completed]
        listItemRef.updateChildValues(childUpdate) { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        } // end setValue
    }
    
    func loadListsFromDB(completion: @escaping (Result<[List], Error>) -> Void){
        ref = Database.database().reference()
        guard let currentUser = UserManager.shared.currentUser else { return }
        let listRef = self.ref.child("users").child(currentUser.uid).child("lists")
        
        listRef.observeSingleEvent(of: .value) { snapshot in
            var lists: [List] = []
            
            for child in snapshot.children {
                print("items")
                guard let listSnapshot = child as? DataSnapshot else {
                    continue
                }
                
                let listId = listSnapshot.key
                guard let listData = listSnapshot.value as? [String: Any] else {
                    continue
                }
                
                guard let listTitle = listData["title"] as? String else {
                    continue
                }
                let itemsDict = listData["items"] as? [String: [String: Any]] ?? [:]
                
                print("listId")
                
                var items: [ListItem] = []
                for (listItemId, itemData) in itemsDict {
                    print("items")
                    guard let name = itemData["name"] as? String,
                          let amount = itemData["amount"] as? Double,
                          let unitsRaw = itemData["units"] as? String,
                          let units = Units(rawValue: unitsRaw),
                          let price = itemData["price"] as? Double,
                          let completed = itemData["completed"] as? Bool else {
                        continue
                    } // end guard
                    
                    let listItem = ListItem(listItemId: listItemId, name: name, amount: amount, units: units, price: price, completed: completed)
                    items.append(listItem)
                } // end for
                let list = List(listId: listId, title: listTitle, items: items)
                lists.append(list)
            } // end for
            completion(.success(lists))
        } withCancel: { error in
            completion(.failure(error))
        } // end observeSingleEvent
    }// end loadListsFromDB
    
    func loadLists() -> [List] {
        guard let data = UserDefaults.standard.data(forKey: listsKey) else {
            return []
        }
        let decoder = JSONDecoder()
        do {
            let lists = try decoder.decode([List].self, from: data)
            print("Loaded data: \(data)")

            print("Loaded lists: \(lists)")
            return lists
        } catch {
            print("Failed to decode lists: \(error)")
            return []
        }
    }
    
    func deleteList(list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else { return }
        ref = Database.database().reference()
        let listRef = self.ref.child("users").child(currentUser.uid).child("lists").child(list.listId)
        
        listRef.removeValue() { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        } // end removeValue
    } // end deleteList
    
    func deleteListItem(listItem: ListItem, list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else { return }
        ref = Database.database().reference()
        let listItemRef = self.ref.child("users").child(currentUser.uid).child("lists").child(list.listId).child("items").child(listItem.listItemId)
        
        listItemRef.removeValue() { error, _ in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        } // end removeListItem
    } // end deleteListItem
    

}
