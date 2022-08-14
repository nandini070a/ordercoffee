//
//  ViewController.swift
//  OrderOwnCoffee
//
//  Created by Nandini Saha on 2022-03-23.
//

import UIKit

class ListTableViewController: UITableViewController, ListOrderDelegate {
 
    private let vm = ListOrderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        vm.getOrder {
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = vm.cellForRowAt(index: indexPath.row)
        cell.textLabel?.text = item.coffeeType
        cell.detailTextLabel?.text = item.coffeeSize
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navC = segue.destination as? UINavigationController {
            if let destinationVC = navC.viewControllers.first as? AddOrderViewController {
                destinationVC.delegate = self
            }
        }
    }
    
    func displayOrder(_ order: Order) {
        let index = vm.numberOfRows()
        vm.listOrder.append(OrderViewModel(order))
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}

