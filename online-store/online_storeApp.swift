//
//  online_storeApp.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI

@main
struct online_storeApp: App {
    
    @StateObject var productManager = ProductManager()
//    @StateObject var todoManager = TodoManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView(productManager: productManager)
//                .environmentObject(cartManager)
//                .environmentObject(todoManager)
        }
    }
}
