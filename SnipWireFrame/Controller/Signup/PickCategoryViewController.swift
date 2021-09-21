//
//  PickCategoryViewController.swift
//  SnipWireFrame
//
//  Created by Zarina Bekova on 8/20/21.
//

import UIKit

class CellClass: UITableViewCell {
    
}

class PickCategoryViewController: UIViewController {

    @IBOutlet weak var btnSelectItem: UIButton!
    @IBOutlet weak var btnSelectCategory: UIButton!
    
    let transparentView = UIView()
    let tableView1 = UITableView()
    
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.register(CellClass.self, forCellReuseIdentifier: "cell")
    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? view.frame
        view.addSubview(transparentView)
        
        tableView1.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0 )
        view.addSubview(tableView1)
        tableView1.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tableView1.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView1.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50) )
        }, completion: nil)
    }
    
    @objc func removeTransparentView() {
        let frames =  selectedButton.frame
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView1.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0 )
        }, completion: nil)
        
    }
    
    @IBAction func selectItembtnClicked(_ sender: UIButton) {
        dataSource = ["Skirt", "Shirt", "Pants", "Scarf", "Candles"]
        selectedButton = btnSelectItem
        addTransparentView(frames: btnSelectItem.frame)
    }
    
    @IBAction func selectCategBtnClicked(_ sender: UIButton) {
        dataSource = ["Bedazzling", "Tie Dye", "Embroidery", "Knitting"]
        selectedButton = btnSelectCategory
        addTransparentView(frames: btnSelectCategory.frame)
    }
}

extension PickCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedButton.setTitle(dataSource[indexPath.row], for: .normal)
        removeTransparentView()
    }
    
}
