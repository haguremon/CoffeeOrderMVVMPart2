//
//  AddOrderViewController.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import UIKit

//値を渡すためのプロトコルを作る
protocol AddCoffeeOrderDelegate {
    func AddCoffeeOrderVCDidSave(order: Order, controller: UIViewController)
    func AddCoffeeOrderVCDidClose(controller: UIViewController)
}


class AddOrderViewController: UIViewController {
    
    var delegate: AddCoffeeOrderDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var ordernameTF: UITextField!
    
    @IBOutlet weak var totalTF: UITextField!
    
    
    private var vm = AddCoffeeOrderViewModel()
    
    private var coffeeSizeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        totalTF.keyboardType = .numberPad
        setupUI()
        
        
    }
    //自作のUISegmentedControlを作成する
    private func setupUI() {
        //１、vm.coffeeSizeのアイテム3種類を入れたそれぞれを入れた
        coffeeSizeSegmentedControl = UISegmentedControl(items: vm.coffeeSize)
        //2, 異なる制約にも適用させた
        coffeeSizeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        //3 viewに表示する
        view.addSubview(coffeeSizeSegmentedControl)
        //4tableViewのボトムから40の所に配置するようにするisActiveで自動的にそうなる
        coffeeSizeSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor,
                                                        constant: 40).isActive = true
        //５、viewのX軸にセンターに自動的に配置 //4,5でViewでのxyを指定してる
        coffeeSizeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    @IBAction  func close(){
        
       if let delegate = self.delegate {
           print("test11111")
        delegate.AddCoffeeOrderVCDidClose(controller: self)
        
       
       }
        
    }
    
    
    @IBAction func save() {
       
        guard let name = ordernameTF.text,
              let total = Double(totalTF.text ?? ""),
              !name.isEmpty, total > 0 else {
            
            let alert = UIAlertController(title: "注文情報", message: "注文情報に間違いがあります", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "注文に戻る", style: .cancel, handler: nil)
            alert.addAction(cancel)
            
            present(alert, animated: true)
            
            return
            
        }
        
        
        
        //SegmentedControlのタイトルの情報を取得
        let coffeeSize = coffeeSizeSegmentedControl.titleForSegment(at: coffeeSizeSegmentedControl.selectedSegmentIndex)
        //コーヒーのタイプを指定 indexPathForSelectedRowで選択してるcellを取得することができる
        guard let selecteindexcell = tableView.indexPathForSelectedRow else { return }
        //ここで登録した情報をどうやって保存するか
        vm.name = name
        vm.total = total
        vm.selectedSize = coffeeSize
        vm.selectedType = vm.coffeeType[selecteindexcell.row]
        WebService().load(resource: Order.create(vm: self.vm)) { reult in
            print(reult)
            print(self.vm)
            switch reult {
            case .success(let order):
                if let oreder = order, let delegate = self.delegate {
                    DispatchQueue.main.async {
                        print("test22222")
                        delegate.AddCoffeeOrderVCDidSave(order: oreder, controller: self)

                    }

                }
            case .failure(let error):
                print("testttttttt")

                print(error)
            }
        }

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //セルをタップした場所に.checkmarkをつける
    }
    //Deselectした時にチェックマークを消す
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
    
}
