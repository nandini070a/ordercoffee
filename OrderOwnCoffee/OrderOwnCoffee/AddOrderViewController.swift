//
//  AddOrderViewController.swift
//  OrderOwnCoffee
//
//  Created by Nandini Saha on 2022-03-24.
//

import UIKit

protocol ListOrderDelegate {
    func displayOrder(_ order: Order)
}

class AddOrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    private var vm = AllOrderViewModel()
    private var segmentedControl = UISegmentedControl()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var delegate: ListOrderDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        configureSegmentedControl()
    }
    
    private func configureSegmentedControl() {
        segmentedControl = UISegmentedControl(items: vm.allOrderVM.coffeeSize)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 0).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @IBAction func saveClicked(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let indexpath = self.tableView.indexPathForSelectedRow,
              let size = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
        else {return}
        guard !name.isEmpty, !email.isEmpty, !size.isEmpty else {return}
        
        vm.allOrderVM.name = name
        vm.allOrderVM.email = email
        vm.allOrderVM.type = vm.allOrderVM.coffeeType[indexpath.row]
        vm.allOrderVM.size = size
        
        vm.allOrderVM.listForTableView { order in
            self.delegate?.displayOrder(order)
            self.dismiss(animated: true, completion: nil)
        }
    }
        
    @IBAction func doneClicked(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.allOrderVM.coffeeType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = vm.allOrderVM.coffeeType
        cell.textLabel?.text = item[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
