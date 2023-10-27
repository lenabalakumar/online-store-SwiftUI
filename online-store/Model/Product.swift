//
//  Product.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import Foundation

/* {
 "id":1,
 "title":"Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
 "price":109.95,
 "description":"Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
 "category":"men's clothing",
 "image":"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
 "rating":{
    "rate":3.9,
    "count":120
    }
 } */

struct Product: Decodable, Identifiable, Equatable {
//    
//    static func == (lhs: Product, rhs: Product) -> Bool {
//        lhs.id == rhs.id && lhs.title == rhs.title && lhs.price == rhs.price && lhs.rating == rhs.rating && lhs.image == rhs.image && lhs.category == rhs.category && lhs.description == rhs.description
//    }
    
    var id: Int
    var title: String
    var price: Float
    var description: String
    var category: String
    var image: String
    var rating: Rating
    var productInCart: inCartStatus = .notInCart
    var quantity: Int = 0
    
    enum inCartStatus {
        case inCart, notInCart
    }
//
//    mutating func changeInCartStatus() {
//        self.productInCart = .inCart
//    }
    
    struct Rating: Decodable, Equatable {
        var rate: Float
        var count: Int
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        price = try values.decode(Float.self, forKey: .price)
        description = try values.decode(String.self, forKey: .description)
        category = try values.decode(String.self, forKey: .category)
        image = try values.decode(String.self, forKey: .image)
        rating = try values.decode(Rating.self, forKey: .rating)
    }
    
    init(id: Int, title: String, price: Float, description: String, category: String, image: String, rating: Rating) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }
}

extension Product {
    static let sampleProduct: Product = Product(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "men's clothing", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 3.9, count: 120))
}
