//
//  ProductManager.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import Foundation

class ProductManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [Product] = []
    @Published var errorMessage: String? = nil
    @Published var total: Float = 0.0
    @Published var numberOfItemsInCart: Int = 0
    let url = URL(string: "https://fakestoreapi.com/products")!
    let apiService = APIService()
    
    init() {
        fetchProducts()
    }
    
    func fetchProducts() {
        
        apiService.fetch(Product.self, url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.errorMessage = error.description
                case .success(let products):
                    self.products = products
                }
            }
        }
    }
    
    func changeInStockDetails(product: Product) -> Void {
            if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index].productInCart = .inCart
        }
    }
    
    func addItemToCart(product: Product) -> Void {
        
        var productToAdd = product
        productToAdd.quantity += 1

        if let index = products.firstIndex(where: { $0.id == productToAdd.id }) {
            if products[index].quantity < 5 {
                products[index].quantity += 1
                products[index].productInCart = .inCart
                calculateNumberOfItemsInCart()
                calculateTotal()
            }
        }
    }
    
    func removeItemFromCart(product: Product) -> Void {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            if products[index].quantity < 2 {
                products[index].productInCart = .notInCart
                products[index].quantity = 0
                calculateNumberOfItemsInCart()
                calculateTotal()
            } else {
                products[index].quantity -= 1
                calculateNumberOfItemsInCart()
                calculateTotal()
            }
        }
    }
    
    func calculateNumberOfItemsInCart() -> Void {
        numberOfItemsInCart = products.filter { $0.productInCart == .inCart }.count
    }
    
    func calculateTotal() -> Void {
        total = products.filter { $0.productInCart == .inCart }.reduce(0) { $0 + Float($1.quantity) * $1.price}
    }
}






