import UIKit

struct Note: Codable {
    // observe the following properties are already Codeable, thus no compiler errors
    let title: String
    let text: String
    let timestamp: Date
}

let newNote = Note(title: "Grocery run", text: "Pick up ketchup, mustard, and lettuce.", timestamp: Date())

// Get Documents URL and create new file.
let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")

// Encode the Note object.
let propertyListEncoder = PropertyListEncoder()
let encodedNote = try? propertyListEncoder.encode(newNote)

// Write the encoded data to the specified file
try? encodedNote?.write(to: archiveURL, options: .noFileProtection)

// Decode data from a file.
let propertyListDecoder = PropertyListDecoder()
if let retrievedNoteData = try? Data(contentsOf: archiveURL),
   let decodedNote = try? propertyListDecoder.decode(Note.self, from: retrievedNoteData) {
    print(decodedNote)
}


let note1 = Note(title: "Note One", text: "This is a sample note.", timestamp: Date())
let note2 = Note(title: "Note Two", text: "This is another sample note.", timestamp: Date())
let note3 = Note(title: "Note Three", text: "This is yet another sample note.", timestamp: Date())
let notes = [note1, note2, note3]

// Find the URL and create a new file.
let documentsArrayDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveArrayURL = documentsArrayDirectory.appendingPathComponent("notes_array_test").appendingPathExtension("plist")

// Encode the array of notes.
let propertyArrayEncoder = PropertyListEncoder()
let encodedArrayNotes = try? propertyArrayEncoder.encode(notes)

// Write the array to disk
try? encodedArrayNotes?.write(to: archiveArrayURL, options: .noFileProtection)

// Read an array from disk
let propertyArrayDecoder = PropertyListDecoder()
if let retrievedArrayNotes = try? Data(contentsOf: archiveArrayURL),
   let decodedArray = try? propertyListDecoder.decode(Array<Note>.self,
                                                      from: retrievedArrayNotes) {
    print(decodedArray)
}

