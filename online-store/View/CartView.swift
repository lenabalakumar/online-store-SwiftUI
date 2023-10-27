//
//  CartView.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var productManager: ProductManager
    var body: some View {
        
        if productManager.products.filter({ $0.productInCart == .inCart}).count > 0 {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(productManager.products.filter({ $0.productInCart == .inCart })) { product in
                        Text(product.title)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Cart")
                
    //            GeometryReader { geometry in
    //            if productManager.total > 0 {
                    Text(productManager.total, format: .number)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding()
                    //                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment:.bottom)
                    //            Text("Hello world!")
    //            }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
