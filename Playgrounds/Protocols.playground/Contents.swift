/* CustomStringConvertible Protocol */

// print() works as expected with built-in types
let hello = "Hello"
let num = 42
let boolean = false
print(hello)
print(num)
print(boolean)

// however, how can we do this with custom types?...
class Shoe1 {
    let color: String
    let size: Int
    let hasLaces: Bool
    
    init(color: String, size: Int, hasLaces: Bool) {
        self.color = color
        self.size = size
        self.hasLaces = hasLaces
    }
}

let myShoe = Shoe1(color: "Black", size: 12, hasLaces: true)
let yourShoe = Shoe1(color: "Red", size: 8, hasLaces: false)

// should have some issues printing
print(myShoe)
print(yourShoe)

// CustomStringConvertible protocol has a required computed property - description
// it returns a String representation of the instance,
// you can adopt the protocol to control how the types are represented in printable String values

// example of adopting a protocol, specifically the CustomStringConvertible one
class Shoe: CustomStringConvertible {
    let color: String
    let size: Int
    let hasLaces: Bool
    
    init(color: String, size: Int, hasLaces: Bool) {
        self.color = color
        self.size = size
        self.hasLaces = hasLaces
    }
    
    // conform to the protocol by adding the required functions or variables,
    // the description property of CustomStringConvertible allows us to return
    // a custom string representation; you'll be familiar with the from other
    // languages with different implementations
    var description: String {
        return "Shoe(color: \(color), size: \(size), hasLaces: \(hasLaces))"
    }
}

let myShoe2 = Shoe(color: "Black", size: 10, hasLaces: true)
let yourShoe2 = Shoe(color: "Blue", size: 4, hasLaces: false)
print(myShoe2)
print(yourShoe2)

/* Equitable protocol is used to define how to compare objects of the same type */
/* Comparable protocol is used to define how to sort objects of the same type */
struct Employee: Equatable {
    var firstName: String
    var lastName: String
    var jotTitle: String
    var phoneNumber: String
    
    // for Equitable protocol, we have to define a static == method that defines
    // how two instances of this object are equal
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return (lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName) &&
        (lhs.jotTitle == rhs.jotTitle) && (lhs.phoneNumber == rhs.phoneNumber)
    }
}

struct Company {
    var name: String
    var employees: [Employee]
}

let currentEmployee = Employee(firstName: "Devere", lastName: "Weaver", jotTitle: "iOS Engineer", phoneNumber: "123")
let selectedEmployee = Employee(firstName: "Dever", lastName: "Weaver", jotTitle: "iOS Engineer", phoneNumber: "123")
let otherEmployee = Employee(firstName: "Devere", lastName: "Weaver", jotTitle: "iOS Engineer", phoneNumber: "123")
print(currentEmployee == selectedEmployee)
print(currentEmployee == otherEmployee)

// the compiler can autogenerate teh Equitable protocol property code if the type is a struct or enum
/* Codeable - encode the type's names and values as key/value pairs to be stored on disk */
struct Dog: Equatable, Comparable, CustomStringConvertible, Codable {
    var name: String
    var breed: String
    
    // autogenerate Equitable code
    
    static func < (lhs: Dog, rhs: Dog) -> Bool {
        return lhs.name < rhs.name
    }
    
    var description: String {
        return "\(name) is a \(breed)."
    }
}

let dog1 = Dog(name: "Stella", breed: "Bulldog")
let dog2 = Dog(name: "Luna", breed: "Doodle")
let dog3 = Dog(name: "Stella", breed: "Bulldog")
let dog4 = Dog(name: "Vinny", breed: "Shepard")
print(dog1 == dog2)
print(dog1 == dog3)
print(dog1 < dog2)    // S comes after L

// use sorted(by:) function to return a sorted array
let dogs = [dog1, dog2, dog4]
let sortedDogs = dogs.sorted(by: <)
print(dogs)
print(sortedDogs)

/* Example of using Codeable protocol to store data to JSON */
import Foundation

let myDog = Dog(name: "Stella", breed: "Bulldog")

// encode to JSON format
let jsonEncoder = JSONEncoder()

// try to encode myDog as json data
// if there is no error then store the json data as a string to
// print to stdout showing it was sucessfullly stored and retrieved
if let jsonData = try? jsonEncoder.encode(myDog),
   let jsonString = String(data: jsonData, encoding: .utf8) {
       print(jsonString)
   }

/* Note: the Codeable protocol will be important when saving user data and
 * working with web services.
 */


/* Creating a Protocol */
// fully defined protocol that requires a fullName property and sayFullName() method
protocol FullyNamed {
    var fullName: String { get }    // computed property => read-only
    
    // notice this isn't implemented, just declared, methods need to have a name,
    // needed parameters, and return type (if any)
    func sayFullName()
}

// test it out
struct Person: FullyNamed {
    var firstName: String
    var lastName: String
    
    // must implement computed property
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
    
    // must also implement the method as well
    func sayFullName() {
        print(fullName)
    }
}
