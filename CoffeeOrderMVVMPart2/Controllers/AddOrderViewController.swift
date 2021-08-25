//
//  AddOrderViewController.swift
//  CoffeeOrderMVVMPart2
//
//  Created by IwasakIYuta on 2021/08/23.
//

import UIKit

class AddOrderViewController: UIViewController {
    
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
    
    @IBAction func save() {
        guard let name = ordernameTF.text,
              let total = Double(totalTF.text ?? ""),
              !name.isEmpty else { return }
        
        
        
        //SegmentedControlのタイトルの情報を取得
        let coffeeSize = coffeeSizeSegmentedControl.titleForSegment(at: coffeeSizeSegmentedControl.selectedSegmentIndex)
        //コーヒーのタイプを指定 indexPathForSelectedRowで選択してるcellを取得することができる
        guard let selecteindexcell = tableView.indexPathForSelectedRow else { return }
        
        vm.name = name
        vm.total = total
        vm.selectedSize = coffeeSize
        vm.selectedType = vm.coffeeType[selecteindexcell.row]
        
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
        print(vm.name ?? "a")
    }
    //Deselectした時にチェックマークを消す
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        
    }
    
    
}
