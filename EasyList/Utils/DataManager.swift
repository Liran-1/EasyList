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
    
    func saveListsToDB(_ lists: [List]) {
        ref = Database.database().reference()
        guard let currentUser = UserManager.shared.currentUser else { return }
        self.ref.child("users").child(currentUser.uid).setValue(["userLists" : lists])
    }
    
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
    
    
    
    
}
