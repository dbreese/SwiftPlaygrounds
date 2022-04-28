import Foundation

struct Employee: Codable {
    var name: String
    var id: Int
    var favoriteToy: Toy?
}

struct Toy: Codable {
    var name: String
}

code(for: "Encode object to JSON", active: false) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let employee = Employee(name: "Dustin", id: 1, favoriteToy: Toy(name: "Motorcycle"))
    let data = try encoder.encode(employee)
    
    print("json = \(String(data: data, encoding: .utf8)!)")
}

code(for: "Decode object to JSON", active: false) {
    let decoder = JSONDecoder()
    
    let json = """
    {
      "name" : "Dustin",
      "id" : 1,
      "favoriteToy" : {
        "name" : "Motorcycle"
      }
    }
    """
    let data = json.data(using: .utf8)!
    let employee = try decoder.decode(Employee.self, from: data)
    
    print("Employee: \(employee)")
}

code(for: "Attempt to decode JSON that doesnt match struct", active: false) {
    let decoder = JSONDecoder()
    
    let json = """
    {
      "name" : "Dustin",
      "id" : 1,
      "UNKNOWN" : 1,
      "favoriteToy" : [
        {
            "name" : "Motorcycle"
        },
        {
            "name" : "Bicycle"
        }
      ]
    }
    """
    let data = json.data(using: .utf8)!
    let employee = try decoder.decode(Employee.self, from: data)
    
    print("Employee: \(employee)")
}

code(for: "Sample creating a JSON Object/dictionary", active: true) {
    let jsonString = """
    {
      "name" : "Dustin",
      "id" : 1,
      "UNKNOWN" : 1,
      "favoriteToys" : [
        {
            "name" : "Motorcycle"
        },
        {
            "name" : "Bicycle"
        }
      ]
    }
    """
    let data = jsonString.data(using: .utf8)!
    guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable:Any] else {
        print("Could not parse json")
        return
    }
    
    print("\(type(of: dict))")
    print("name=\(dict["name"]!)")
    print("toys=\(dict["favoriteToys"]!)")
}
