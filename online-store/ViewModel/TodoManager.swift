//
//  TodoManager.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 25/10/2023.
//

import Foundation

class TodoManager: ObservableObject {
    @Published var todos: [Todo] = []
    let apiService = APIService()
    let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
    @Published var errorMessage: String? = nil
    
    init() {
        fetchTodos()
    }
    
    func fetchTodos() {
        
        apiService.fetch(Todo.self, url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let todos):
                    self.todos = todos
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
