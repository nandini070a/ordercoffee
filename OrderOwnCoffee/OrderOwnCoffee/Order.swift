//
//  Order.swift
//  OrderOwnCoffee
//
//  Created by Nandini Saha on 2022-03-24.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case latte
    case capuccino
    case cortado
    case espresso
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
    
    init?(_ vm: AddOrderViewModel) {
        guard let name = vm.name,
              let email = vm.email,
              let type = vm.type,
              let size = vm.size
        else {return nil}
        
        self.name = name
        self.email = email
        self.type = CoffeeType(rawValue: type.lowercased())!
        self.size = CoffeeSize(rawValue: size.lowercased())!
    }
    
    static func create(_ vm: AddOrderViewModel) -> Resource<Order> {
        let order = Order(vm)
        guard let url = Constants.Urls.urlString else {fatalError()}
        guard let data = try? JSONEncoder().encode(order) else {fatalError()}
        
        var resource = Resource<Order>(url)
        resource.httpMethod = .post
        resource.body = data
        return resource
    }
}
