//
//  TodoListView.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 25/10/2023.
//

import SwiftUI

struct TodoListView: View {
    @EnvironmentObject var todoManager: TodoManager
    var body: some View {
        List {
            ForEach(todoManager.todos) { todo in
                Text(todo.description)
            }
            .onMove { from, to in
                todoManager.todos.move(fromOffsets: from, toOffset: to)
            }
            .onDelete { indexSet in
                todoManager.todos.remove(atOffsets: indexSet)
            }
        }
        .listStyle(.plain)
       
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environmentObject(TodoManager())
    }
}
