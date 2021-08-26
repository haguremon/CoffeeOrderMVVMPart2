//
//  OrdersTableViewController.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import UIKit


class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    //１、viewにデータを表示する権限を持つvmを作成
    var ordersListViewModel = OrdersListViewModel()
    
    func AddCoffeeOrderVCDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        print("test222")
        let orderVM = OrderViewModel(order: order)
        self.ordersListViewModel.orderViewModels.append(orderVM)
        
        tableView.insertRows(at: [IndexPath.init(row: self.ordersListViewModel.orderViewModels.count - 1, section: 0)], with: .automatic)
        tableView.reloadData()
    
    }
    
    func AddCoffeeOrderVCDidClose(controller: UIViewController) {
    
        controller.dismiss(animated: true, completion: nil)
        print("test1111")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showOrderList()
   
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav2 = segue.destination as? UINavigationController,
              let vc2 = nav2.viewControllers.first as? AddOrderViewController else {
            print("test")
            return
            
        }
        vc2.delegate = self
    
    }
   
    private func showOrderList(){
        
            
        WebService().load(resource: Order.all) { [ weak self ] result in
          
            //let result: Result<[Order], NetWorkError>なので成功と失敗のケースを書かないといけない
            switch result {
            
            case .success(let orders):
                //２、ここで配列のデータを取得
                self?.ordersListViewModel.orderViewModels = orders.map(OrderViewModel.init)
               //非同期使わなくてもいいよーデータを取得するときにしてるので
                    self?.tableView.reloadData()
               
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return ordersListViewModel.orderViewModels.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let order = ordersListViewModel.forRowAtindex(at: indexPath.row)
        let font = UIFont.boldSystemFont(ofSize: 17)
        cell.textLabel?.font = font
        cell.textLabel?.text = order.coffeeName
        cell.detailTextLabel?.font = font
        cell.detailTextLabel?.text = order.size
        return cell
    }

 

}
