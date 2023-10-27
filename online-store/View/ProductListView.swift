//
//  ProductListView.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var productManager: ProductManager
//    let cartManager: CartManager
    
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(productManager.products) { product in
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: product.image)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)

                            Text(product.title)
                        }
                        
                        Text("$ \(String(format: "%.2f", product.price))")
                        
                        switch product.productInCart {
                        case .inCart:
                            HStack {
                                
                                Button {
                                    productManager.removeItemFromCart(product: product)
                                } label: {
                                    Text("-")
                                }.buttonStyle(.bordered)

                                Text(product.quantity, format: .number)
                                    .font(.callout)
                                    .padding(.horizontal, 4)
                                
                                Button {
                                    productManager.addItemToCart(product: product)
                                } label: {
                                    Text("+")
                                }.buttonStyle(.bordered)
                                
                            }.frame(maxWidth: .infinity, alignment: .trailing)
                                
                        case .notInCart:
                            Button {
                                productManager.addItemToCart(product: product)
                            } label: {
                                Text("Add to cart")
                            }.buttonStyle(.bordered)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Products")
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: CartView(productManager: productManager)) {
                        Text("Items: \(productManager.numberOfItemsInCart)")
                    }
                }
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(productManager: ProductManager())
    }
}
