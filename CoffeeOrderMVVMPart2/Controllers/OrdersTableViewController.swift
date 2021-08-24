//
//  OrdersTableViewController.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import UIKit

class OrdersTableViewController: UITableViewController {
    
    //１、viewにデータを表示する権限を持つvmを作成
    var ordersListViewModel = OrdersListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showOrderList()
   
    }
    
    private func showOrderList(){
        
        
        guard let coffeeUrl = URL(string: "https://island-bramble.glitch.me/orders") else { return }
        //配列の注文にする予定なのでResourceのジェリックの値を配列に設定　そして引数にその型にあったUrlにする
        
        let resource = Resource<[Order]>(url: coffeeUrl)

    
        WebService().load(resource: resource) { [ weak self ] result in
          
            //let result: Result<Order, NetWorkError>なので成功と失敗のケースを書かないといけない
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
