//
//  ListOrderViewModel.swift
//  OrderOwnCoffee
//
//  Created by Nandini Saha on 2022-03-24.
//

import UIKit

class ListOrderViewModel {
    var listOrder = [OrderViewModel]()
    
    func numberOfRows() -> Int {
        return listOrder.count
    }
    
    func cellForRowAt(index: Int) -> OrderViewModel {
        return listOrder[index]
    }
    
    func getOrder(completionHandler: @escaping () -> Void) {
        guard let url = Constants.Urls.urlString else {return}
        let resource = Resource<[Order]?>(url)
        Webservice().fetch(resource: resource) { result in
            switch result {
            case .success(let order):
                if let order = order {
                    for item in order {
                        self.listOrder.append(OrderViewModel(item))
                    }
                    DispatchQueue.main.async {
                        completionHandler()
                    }
                }
            case .failure(let order):
                print(order)
            }
        }
    }
}

struct OrderViewModel {
    
    let order: Order
    
    init(_ order: Order) {
        self.order = order
    }
    
    var coffeeType: String {
        return order.type.rawValue
    }
    
    var coffeeSize: String {
        return order.size.rawValue
    }
}
