import UIKit
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

var cancellables = Set<AnyCancellable>()


code(for: "URL retrieval", active: false) {
    var posts: [PostModel] = []
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    URLSession.shared.dataTaskPublisher(for: url)
    
    // subscribe on background queue (not necessarily needed for this example, but good example)
        .subscribe(on: DispatchQueue.global(qos: .background))
    
    // receive on main
        .receive(on: DispatchQueue.main)
    
        .tryMap { (data, response) -> Data in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            return data
        }
    
        .decode(type: [PostModel].self, decoder: JSONDecoder())
    
        .sink { (completion) in
            print("COMPLETION: \(completion)")
            PlaygroundPage.current.finishExecution()
            
        } receiveValue: { (returnedPosts) in
            posts = returnedPosts
            print("Posts: \(posts.count)")
        }
    
        .store(in: &cancellables)
}

code(for: "Passthrough publisher", active: false) {
    let passthroughSubject = PassthroughSubject<Int, Error>()
    let cancellable = passthroughSubject
        .sink(receiveCompletion: { c in
            print("COMPLETION: \(c)")
        }, receiveValue: { i in
            print("New value: \(i)")
        })
    
    passthroughSubject.send(5)
    passthroughSubject.send(10)
    passthroughSubject.send(completion: .finished)
    passthroughSubject.send(15)
    
    cancellable.cancel()
    
    passthroughSubject.send(15)
}

code(for: "Chained Publisher with map vs tryMap", active: false) {
    let arrayPublisher = ["H","E","L","L","O","x"].publisher
    _ = arrayPublisher
        .tryMap { s -> String in
            if s.uppercased() == "X" {
                throw URLError.init(.badServerResponse)
            }
            return s.uppercased()
        }
        .map { s in
            return s.uppercased() + "..."
        }
        .map { s in
            return "..." + s.uppercased()
        }
    // Because we are using tryMap above, sink must also supply receiveCompletion because trpMap can throw. We would not need it if we just used map()
        .sink(receiveCompletion: { c in
            print("Completion: \(c)")
        }, receiveValue: { s in
            print("value=\(s), \(type(of: s))")
        })
}

code(for: "Chained Publisher converting string->int->string as an example", active: false) {
    // as an example, just going to chain publishers to convert from S->I->S
    // if non number is found, will skip that element
    let romanNumerals = ["I", "II", "III", "IX" ]
    let arrayPublisher = ["1", "2", "3", "X", "4", "1", "3"].publisher
    _ = arrayPublisher
        .filter { s in
            s != "X"
        }
        .map { s -> Int in
            let i = Int(s)!
            return i
        }
        .map {i -> String in
            return "\(romanNumerals[i - 1])"
        }
    // Because we are using tryMap above, sink must also supply receiveCompletion because trpMap can throw. We would not need it if we just used map()
        .sink(receiveCompletion: { c in
            print("Completion: \(c)")
        }, receiveValue: { s in
            print("value=\(s), \(type(of: s))")
        })
}

code(for: "Passthrough publisher with complex json", active: false) {
    
    struct People: Decodable {
        let name: String
        let age: Int
    }
    struct Response: Decodable {
        let records: [People]
    }
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    passthroughSubject
        .tryMap { (data) throws -> [People] in
            let decoder = JSONDecoder()
            let response = try decoder.decode(Response.self, from: data.data(using: .utf8)!)
            return response.records
        }
        .sink(receiveCompletion: { c in
            print("Sink Complete: \(c)")
        }, receiveValue: { people in
            people.forEach { print("\($0.name) - \($0.age)")}
        })
        .store(in: &cancellables)
    
    passthroughSubject.send("""
        {"records" : [
                {"name":"Harper", "age": 10},
                {"name":"Paislee", "age": 10},
                {"name":"Ethan", "age": 19},
                {"name":"Ben", "age": 16},
            ] }
""")
}

code(for: "Example using Just publisher", active: true) {
    // Take a string, convert to array of chars, filter all non-vowels
    let publisher = Just("this is a test")
    publisher.map { s in
        // convert and publish an array value
        return Array(s)
    }
    .map({ e in
        Just(e)
    })
    .eraseToAnyPublisher()
    .filter { e in
        let c = "\(e)".uppercased()
        print("c=\(c)")
        return ["A", "E", "I", "O", "U"].contains(c)
    }
    .sink { s in
        print("value=\(s)")
    }
}

// TODO: zip, reduce, collect, dropJust

