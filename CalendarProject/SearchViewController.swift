//
//  SearchViewController.swift
//  CalendarProject
//
//  Created by user228274 on 10/26/22.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchLbl.layer.borderColor = UIColor.black.cgColor
        searchLbl.layer.borderWidth  = 2.0
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var searchLbl: UIButton!
    
    @IBAction func searchBtn(_ sender: Any) {

    }
    
}
