//
//  CartView.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI
import StripePaymentSheet

struct CartView: View {
    @ObservedObject var productManager: ProductManager
    var body: some View {
        
        if productManager.products.filter({ $0.productInCart == .inCart}).count > 0 {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(productManager.products.filter({ $0.productInCart == .inCart })) { product in
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.callout)
                            Text("Quantity: \(product.quantity)")
                                .font(.caption)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Cart")
                
                
                if let paymentSheet = productManager.paymentSheet {
                    PaymentSheet.PaymentButton(
                      paymentSheet: paymentSheet,
                      onCompletion: productManager.onPaymentCompletion
                    ) {
                        Text("$ \(String(format: "%.2f", productManager.total))")
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding()
                  } else {
                    Text("Loading…")
                  }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onAppear {
                productManager.preparePaymentSheet()
            }
        } else {
            Text("No items in cart!")
        }
      
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(productManager: ProductManager())
    }
}
