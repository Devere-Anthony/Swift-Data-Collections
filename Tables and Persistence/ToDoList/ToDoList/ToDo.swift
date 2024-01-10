import Foundation

struct ToDo: Equatable {
    let id = UUID()    // each instance will have a unique id
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
}
