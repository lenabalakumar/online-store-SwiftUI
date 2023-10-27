//
//  CartManager.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import Foundation

class CartManager: ObservableObject {
    @Published var cartProducts: [CartProduct] = []
    @Published var total: Float = 0.0
    
    init() {
        
    }
    
    func addProduct(productToAdd product: CartProduct) -> Void {
        
        cartProducts.append(product)
        changeInStock(product: product.product)
    }
    
    func changeInStock(product: Product) {
        
    }
}
