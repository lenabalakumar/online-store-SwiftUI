//
//  ProductView.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI

struct ProductView: View {
    
    let product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ScrollView {
            VStack {
                
                ZStack(alignment: .bottomTrailing) {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    HStack {
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(String(format: "%.2f", product.rating.rate))")
                        }
                        
                        Text("-")
                        
                        HStack {
                            Image(systemName: "person.3.sequence.fill")
                            Text("\(String(product.rating.count))")
                        }
                    }
                    .padding(8)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    .padding()


                }

                VStack(alignment: .leading) {
                    Text(product.title)
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding(.vertical)
                    HStack {
                        Text("men's clothing")
                            .textCase(.uppercase)
                        Spacer()
                        Text("$ \(String(format: "%.2f", product.price))")
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Button {
                    cartManager.addProduct(productToAdd: CartProduct(product: product, quantity: 1))
                } label: {
                    Text("Add to cart")
                }
                .buttonStyle(FullButtonStyle())

            }
            .padding()
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product.sampleProduct)
    }
}
