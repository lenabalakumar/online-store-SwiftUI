//
//  ProductManager.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import Foundation
import StripePaymentSheet

class ProductManager: ObservableObject {
    
    let backendUrl: URL = URL(string: "http://localhost:7722/payment-sheet")!
    
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    
    @Published var products: [Product] = []
    @Published var cart: [Product] = []
    @Published var errorMessage: String? = nil
    @Published var total: Float = 0.0
    @Published var numberOfItemsInCart: Int = 0
    private(set) var isPaymentComplete: Bool = false {
        didSet {
            cart = []
        }
    }
    
    let url = URL(string: "https://fakestoreapi.com/products")!
    let apiService = APIService()
    
    init() {
        fetchProducts()
    }
    
    func preparePaymentSheet() {
        var request = URLRequest(url: backendUrl)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error \(error)")
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print("Error \(response)")
            }
            
            guard let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                        let customerId = json["customer"] as? String,
                        let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                        let paymentIntentClientSecret = json["paymentIntent"] as? String,
                        let publishableKey = json["publishableKey"] as? String,
                        let self = self else {
                    // Handle error
                    return
                  }
            
            STPAPIClient.shared.publishableKey = publishableKey
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Soda Inc"
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.allowsDelayedPaymentMethods = true
            
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            }
        }
        
        task.resume()
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        switch result {
        case .completed:
            self.isPaymentComplete = true
            clearCart()
        case .canceled:
            print("Payment is cancelled!")
        case .failed(error: let error):
            print("Error in processing payment: \(error)")
        }
        
      self.paymentResult = result
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
    
    func clearCart() -> Void {
        products.indices.filter { products[$0].productInCart == .inCart }
            .forEach { products[$0].productInCart = .notInCart }
        calculateTotal()
        calculateNumberOfItemsInCart()
    }
    
    func calculateNumberOfItemsInCart() -> Void {
        numberOfItemsInCart = products.filter { $0.productInCart == .inCart }.count
    }
    
    func calculateTotal() -> Void {
        total = products.filter { $0.productInCart == .inCart }.reduce(0) { $0 + Float($1.quantity) * $1.price}
    }
}






