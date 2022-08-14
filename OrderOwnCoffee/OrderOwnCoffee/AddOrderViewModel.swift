//
//  AddOrderViewModel.swift
//  OrderOwnCoffee
//
//  Created by Nandini Saha on 2022-03-24.
//

import UIKit

struct AllOrderViewModel {
    var allOrderVM = AddOrderViewModel()
}

struct AddOrderViewModel {
    
    var name: String?
    var email: String?
    var type: String?
    var size: String?
    
    var coffeeType: [String] {
        return CoffeeType.allCases.map {$0.rawValue.capitalized}
    }
    
    var coffeeSize: [String] {
        return CoffeeSize.allCases.map {$0.rawValue.capitalized}
    }

    func listForTableView(completionHandler: @escaping (Order) -> Void) {
        Webservice().fetch(resource: Order.create(self)) { result in
            switch result {
            case .success(let order):
                DispatchQueue.main.async {
                    completionHandler(order)
                }
            case .failure(let order):
                print(order)
            }
        }
    }
}
