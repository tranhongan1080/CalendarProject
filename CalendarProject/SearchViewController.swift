//
//  SearchViewController.swift
//  CalendarProject
//
//  Created by user228274 on 10/26/22.
//

import UIKit
import Foundation

var searchQuery = ""

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var event = [String]()
    var eventAndDate: [String:String] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchLbl.layer.borderColor = UIColor.black.cgColor
        searchLbl.layer.borderWidth  = 2.0
    }
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var searchLbl: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func searchBtn(_ sender: Any) {
        //eventLists, contains array of struct Event, eventLists[index].name to access lists of events
        
        searchQuery = name.text!
        
        for i in 0..<eventsList.count{
            event.append(eventsList[i].name)
            eventAndDate[eventsList[i].name] = "\(CalendarHelper().monthString(date: eventsList[i].date)) \(CalendarHelper().dayOfMonth(date: eventsList[i].date)), \(CalendarHelper().yearString(date: eventsList[i].date))"
        }
        
        //let itemExists = event.contains(where: {
            //$0.range(of: searchToSearch!, options: .caseInsensitive) != nil
        //})
        //createAlert(title: "Event found", msg: "\(String(describing: name.text)) at \(eventAndDate[name.text!]!)")

        let matchingTerms = event.filter({
            $0.range(of: searchQuery, options: .caseInsensitive) != nil
        })
        
        if(name.text == ""){
            createAlert(title: "Empty input", msg: "Please enter the name of the event.")
        }
    
        if matchingTerms.count == 0{
            popViewAlert(title: "Event not found", msg: "Would you like to create a new event?")
        }
        else{
            //createAlert(title: "Event found", msg: " '\(matchingTerms[0])' will occur on \(String(describing: eventAndDate[matchingTerms[0]]!))")
            tableView.reloadData()
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsForName(name: searchQuery).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventCell
//        let event = Event().eventsForName(name: searchQuery)[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cellEventLabel = cell.viewWithTag(1) as! UILabel
        
        let event = Event().eventsForName(name: searchQuery)[indexPath.row]
//        let str = CalendarHelper().timeString(date: event.date)

//        let boldText = str
//        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)]
//        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
//
//        let normalText = "   -   " + event.name
//        let normalString = NSMutableAttributedString(string:normalText)
//
//        attributedString.append(normalString)
//        cell.eventLabel.attributedText = attributedString
        // print("Attributed String: \(attributedString)")
        
        let name = event.name + "   -   "
        let time = CalendarHelper().timeString(date: event.date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        
        cellEventLabel.text = "\(name)\(dateFormatter.string(from: event.date)) at \(time)"
        return cell
    }
    
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func popViewAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.performSegue(withIdentifier: "edit_seg", sender: self)
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    
}

