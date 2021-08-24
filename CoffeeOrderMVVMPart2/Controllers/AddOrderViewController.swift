//
//  AddOrderViewController.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import UIKit

class AddOrderViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var vm = AddCoffeeOrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
      
        
    }
      

}
extension AddOrderViewController: UITableViewDataSource,  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.coffeeType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = vm.coffeeType[indexPath.row]
        
        return cell
    }
    
    
    
}
