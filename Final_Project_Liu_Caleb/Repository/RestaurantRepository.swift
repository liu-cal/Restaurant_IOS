
import FirebaseFirestore
import FirebaseFirestoreSwift

class RestaurantRepository: ObservableObject{
    static var shared = RestaurantRepository()
    
    @Published var mealList: [Meal] = []
    @Published var customerList: [Customer]=[]
    @Published var orderList: [Order]=[]
    @Published var deliveryList:[Delivery]=[]
    private let mealPath = "meals"
    private let customerPath="customers"
    private let orderPath="orders"
    private let deliveryPath="deliveries"
    private let restaurant = Firestore.firestore()
    
    init(){
        getMeals()
    }
    
    //meals
    func getMeals(){
        restaurant.collection(mealPath).addSnapshotListener{ snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self.mealList = snapshot?.documents.compactMap {
                try? $0.data(as: Meal.self)
            } ?? []
            print(self.mealList)
        }
    }
    
    func getMeal(byName name: String, completion: @escaping (Meal?) -> Void) {
            let query = restaurant.collection(mealPath).whereField("name", isEqualTo: name)

            query.getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }

                guard let document = snapshot?.documents.first else {
                    // No document found with the given name
                    completion(nil)
                    return
                }

                do {
                    let meal = try document.data(as: Meal.self)
                    completion(meal)
                } catch {
                    print("Error decoding meal: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    
    //customers
    func getCustomers(){
        restaurant.collection(customerPath).addSnapshotListener{ snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self.customerList = snapshot?.documents.compactMap {
                try? $0.data(as: Customer.self)
            } ?? []
            print(self.customerList)
        }
    }
    
    func getCustomer(byName name: String, completion: @escaping (Customer?) -> Void) {
            let query = restaurant.collection(customerPath).whereField("name", isEqualTo: name)

            query.getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }

                guard let document = snapshot?.documents.first else {
                    // No document found with the given name
                    completion(nil)
                    return
                }

                do {
                    let customer = try document.data(as: Customer.self)
                    completion(customer)
                } catch {
                    print("Error decoding customer: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    
    func addCustomer(_ customer: Customer){
        do {
            _ = try restaurant.collection(customerPath).addDocument(from: customer)
        }
        catch{
            fatalError("Adding Customer Failed.")
        }
    }
    
    func deleteAllCustomers() {
            restaurant.collection(customerPath).getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                guard let documents = snapshot?.documents else {
                    // No documents found
                    return
                }

                for document in documents {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error deleting customer: \(error.localizedDescription)")
                        } else {
                            print("Customer deleted successfully")
                        }
                    }
                }
            }
        }
    
    
    //orders
    func getOrders(){
        restaurant.collection(orderPath).addSnapshotListener{ snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self.orderList = snapshot?.documents.compactMap {
                try? $0.data(as: Order.self)
            } ?? []
            print(self.orderList)
        }
    }
    
    func addOrder(_ order: Order){
        do {
            _ = try restaurant.collection(orderPath).addDocument(from: order)
        }
        catch{
            fatalError("Adding Order Failed.")
        }
    }
    
    func updateOrder(_ order: Order){
        if let documentId = order.id {
            restaurant.collection(orderPath).document(documentId).setData(["name":order.mealName, "quantity":order.mealName], merge: true)
        }
    }
    
    func deleteAllOrders() {
            restaurant.collection(orderPath).getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                guard let documents = snapshot?.documents else {
                    // No documents found
                    return
                }

                for document in documents {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error deleting order: \(error.localizedDescription)")
                        } else {
                            print("Order deleted successfully")
                        }
                    }
                }
            }
        }
    

    //deliveries
    func deleteAllDeliveries() {
            restaurant.collection(deliveryPath).getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                guard let documents = snapshot?.documents else {
                    // No documents found
                    return
                }

                for document in documents {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error deleting delivery: \(error.localizedDescription)")
                        } else {
                            print("Delivery deleted successfully")
                        }
                    }
                }
            }
        }
    
    func getDeliveries(){
        restaurant.collection(deliveryPath).addSnapshotListener{ snapshot, error in
            if let error = error {
                print(error)
                return
            }
            self.deliveryList = snapshot?.documents.compactMap {
                try? $0.data(as: Delivery.self)
            } ?? []
            print(self.deliveryList)
        }
    }
    
    func getDelivery(byDeliveryId deliveryId: String, completion: @escaping (Delivery?) -> Void) {
            let query = restaurant.collection(deliveryId).whereField("deliveryId", isEqualTo: deliveryId)

            query.getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }

                guard let document = snapshot?.documents.first else {
                    // No document found with the given name
                    completion(nil)
                    return
                }

                do {
                    let delivery = try document.data(as: Delivery.self)
                    completion(delivery)
                } catch {
                    print("Error decoding delivery: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    
    func addDelivery(_ delivery: Delivery){
        do {
            _ = try restaurant.collection(deliveryPath).addDocument(from: delivery)
        }
        catch{
            fatalError("Adding Delivery Failed.")
        }
    }
    
    func updateDelivery(_ delivery: Delivery){
        if let documentId = delivery.id {
            restaurant.collection(orderPath).document(documentId).setData(["address":delivery.address, "deliveryTime":delivery.deliveryTime, "totalCost": delivery.totalCost], merge: true)
        }
    }
    
    func deleteDelivery(_ delivery: Delivery){
        if let documentId = delivery.id {
            restaurant.collection(deliveryPath).document(documentId).delete{
                error in
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
