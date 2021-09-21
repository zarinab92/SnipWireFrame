//
//  DetailViewController.swift
//  SnipWireFrame
//
//  Created by Zarina Bekova on 8/11/21.
//

import UIKit

class CellsClass: UITableViewCell {
    
}

class DetailViewController: UIViewController {
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!
    
    var transparentView = UIView()
    var selectedButton = UIButton()
    var tblView = UITableView()
    var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(CellsClass.self, forCellReuseIdentifier: "cell")

    }
    
    func addTransparentView(frames: CGRect) {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? view.frame
        view.addSubview(transparentView)
        
        tblView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0 )
        view.addSubview(tblView)
        tblView.layer.cornerRadius = 5
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        tblView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tblView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(self.dataSource.count * 50))
        }, completion: nil)
        
    }
    
   @objc func removeTransparentView() {
    let frames = selectedButton.frame
    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
        self.transparentView.alpha = 0
        self.tblView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: 0)
    }, completion: nil)
    
    
        
    }
    
    @IBAction func btnAgeClicked(_ sender: UIButton) {
        dataSource = ["25", "26"]
        selectedButton = ageButton
        addTransparentView(frames: selectedButton.frame)
    }
    
    @IBAction func btnGenderClicked(_ sender: UIButton) {
//        dataSource = ["Male", "Female", "Other"]
        selectedButton = genderButton
        addTransparentView(frames: selectedButton.frame)
    }
    
    @IBAction func btnSkipClicked(_ sender: UIButton) {
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
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
