

import FirebaseFirestoreSwift

struct Customer: Identifiable, Codable{
    @DocumentID var id: String?
    var fName: String=""
    var lName: String=""
    var username: String=""
    var password: String=""
    
    init(){}
    
    init(fName: String, lName: String, username: String, password: String){
        self.fName=fName
        self.lName=lName
        self.username=username
        self.password=password
    }
}
