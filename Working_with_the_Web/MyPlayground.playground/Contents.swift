/* Collection Functions Using Closures */

// Map()
// e.g. Start off with a collection of first names and use map() to get an array of full names.

// Initial array
let names = ["Johnny", "Nellie", "Aaron", "Rachel"]

// Create an empty array that will be used to store the full names
var fullNames: [String] = []

// 1. Use a for-in  create these full names and add them to the array.
for name in names {
    let fullName = name + " Smith"
    fullNames.append(fullName)
}
print(fullNames)

// 2. Use map() to create full names.

// Create a new array of full names.
fullNames = []

// Here, map takes a closure as a parameter that we'll call name and
// returns a modified string. The closure is executed on each object in the
// array containing first names.
fullNames = names.map { (name) -> String in
    return name + " Smith"
}
print(fullNames)


// Filter()
// e.g. Filter out numbers that are less than 20 from a collection.
var numbers = [4, 8, 15, 16, 23, 42]
var numbersLessThan20: [Int] = []

// Using a for-in loop
for number in numbers {
    if number < 20 {
        numbersLessThan20.append(number)
    }
}
print(numbersLessThan20)

// Using filter()
numbersLessThan20 = []

numbersLessThan20 = numbers.filter { (number) -> Bool in
    return number < 20
}
print(numbersLessThan20)

// Reduce()
// e.g. Sum all the numbers in an array.
numbers = [8, 6, 7, 5, 3, 0, 9]
var total = 0

// Using a for-in loop
for number in numbers {
    total += number
}
print(total)

// Using reduce()
total = numbers.reduce(0) { (currentTotal, newValue) -> Int in
    return currentTotal + newValue
}
print(total)

// Using reduce() with reduced syntax
total = numbers.reduce(0, +)
print(total)
