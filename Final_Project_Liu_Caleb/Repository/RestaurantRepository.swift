//
//  TodoRepository.swift
//  TodoFirebaseEl
//
//  Created by macuser on 2023-11-09.
//

import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantRepository: ObservableObject{
    static var shared = TodoRepository()
    
    @Published var list: [Todo] = []
    private let path = "todos"
    private let store = Firestore.firestore()
    
    init(){
        get()
    }
    
    
    func get(){
        store.collection(path).addSnapshotListener{ snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self.list = snapshot?.documents.compactMap {
                try? $0.data(as: Todo.self)
            } ?? []
            print(self.list)
        }
    }
    func add(_ todo: Todo){
        do {
            _ = try store.collection(path).addDocument(from: todo)
        }
        catch{
            fatalError("Adding Todo Failed.")
        }
    }
    func update(_ todo: Todo){
        if let documentId = todo.id {
            store.collection(path).document(documentId).setData(["title":todo.title, "notes":todo.notes], merge: true)
        }
    }
    func delete(_ todo: Todo){
        if let documentId = todo.id {
            store.collection(path).document(documentId).delete{
                error in
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
