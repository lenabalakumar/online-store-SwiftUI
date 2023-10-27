//
//  CartProduct.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import Foundation

struct CartProduct: Equatable {
    
//    static func == (lhs: CartProduct, rhs: CartProduct) -> Bool {
//        lhs.product == rhs.product && lhs.quantity == rhs.quantity
//    }
    
    var product: Product
    var quantity: Int
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
}
