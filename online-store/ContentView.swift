//
//  ContentView.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var productManager: ProductManager
    
    var body: some View {
        ProductListView(productManager: productManager)
//        TodoListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(productManager: ProductManager())
//            .environmentObject(CartManager())
//            .environmentObject(TodoManager())
    }
}
