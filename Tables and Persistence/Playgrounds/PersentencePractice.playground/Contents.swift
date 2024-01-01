import UIKit

struct Note: Codable {
    // observe the following properties are already Codeable, thus no compiler errors
    let title: String
    let text: String
    let timestamp: Date
}

// instance of Note that can be encoded
let newNote = Note(title: "Grocery run", text: "Pick up ketchup, mustard, and lettuce.", timestamp: Date())

// use Encoder to encode a value to a plist by creating an instance of PropertyListEncoder
let propertyListEncoder = PropertyListEncoder()
if let encodedNote = try? propertyListEncoder.encode(newNote) {
    print(encodedNote)
    
    // decode with PropertyListDecoder
    let propertListDecoder = PropertyListDecoder()
    if let decodedNote = try? propertListDecoder.decode(Note.self, from: encodedNote) {
        print(decodedNote)
    }
}


