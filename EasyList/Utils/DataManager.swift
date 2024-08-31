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
        }
    }
    
    func addList(list: List, completion: @escaping (Result<Void, Error>) -> Void) {
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
            }
        } catch let error {
            completion(.failure(error))
        }
        
    }
    
    func addListItem(listItem: ListItem, list: List, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = UserManager.shared.currentUser else { return }
        ref = Database.database().reference()
        let listItemRef = self.ref.child("users").child(currentUser.uid).child("lists").child(list.listId).child(listItem.listItemId)
        
        do {
            let listItemData = try JSONEncoder().encode(listItem)
            let listItemJSON = try JSONSerialization.jsonObject(with: listItemData, options: [])
            listItemRef.setValue(listItemJSON) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
            
    }
    
    func saveListsToDB(_ lists: [List]) {
        ref = Database.database().reference()
        guard let currentUser = UserManager.shared.currentUser else { return }
        self.ref.child("users").child(currentUser.uid)
//        self.ref.child("users").child(currentUser.uid).setValue(["userLists" : lists])
//        let listsRef = ref.child("users").child(currentUser.uid).child("lists")
//        
//        var errors: [Error] = []
//        
//        for list in lists {
//            
//            do {
//                let listData = try JSONEncoder().encode(list)
//                let listJSON = try JSONSerialization.jsonObject(with: listData, options: [])
//                listsRef.child(list.listId).setValue(listJSON) { error, _ in
//                    if let error = error {
//                        errors.append(error)
//                    }
//                }
//            } catch {
//                errors.append(error)
//            }
//        }
        
    } // saveListsToDB
    
    func loadListsFromDB() async  -> [List]{
        ref = Database.database().reference()
        guard let currentUser = UserManager.shared.currentUser else { return [] }
        do {
            let snapshot = try await ref.child("users/\(currentUser.uid)").getData()
            print("snapshot = \(snapshot)")
//            let lists = snapshot.value as? [List] ?? []
//            return lists
        } catch {
            print (error)
        }
        return loadLists()
    }
    
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
    
    func deleteList() {
        
    }
    
    func deleteItem() {
        
    }
    
    
    
    
}
