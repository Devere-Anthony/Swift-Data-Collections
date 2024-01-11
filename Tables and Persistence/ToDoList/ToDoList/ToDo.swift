import Foundation

struct ToDo: Equatable, Codable {
//================================================
// Class Properites
//================================================
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    // Conform to Equatable
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
   
    // Keep track of the app's Document directory and create a property list to store these objects.
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
//================================================
// Class Methods
//================================================
    init(title: String, isComplete: Bool, dueDate: Date, notes: String? = nil) {
        /* Custom initializer to help ToDo conform to Codable. */
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static func loadToDos() -> [ToDo]? {
        /* Unarchive ToDo data and load it from disk. */
        guard let codedToDos = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    
    static func saveToDos(_ toDos: [ToDo]) {
        /* Encode and archive the objects currently in the to do list. */
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
}
