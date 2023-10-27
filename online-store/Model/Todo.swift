//
//  Todo.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 25/10/2023.
//

import Foundation

/*
 {
   "userId": 1,
   "id": 1,
   "title": "delectus aut autem",
   "completed": false
 }
 */

struct Todo: Identifiable, CustomStringConvertible, Decodable {
    var id: Int
    var userId: Int
    var title: String
    var completed: Bool
    
    var description: String {
        "Todo is \(title) with status \(completed ? "complete" : "incomplete") created by \(userId)"
    }
    
    init(id: Int, userId: Int, title: String, completed: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.completed = completed
    }
    
    enum CodingKeys: CodingKey {
        case id
        case userId
        case title
        case completed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.title = try container.decode(String.self, forKey: .title)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
}

extension Todo {
    static var sampleTodo: Todo = Todo(id: 1, userId: 1, title: "Get good at coding!", completed: false)
}
