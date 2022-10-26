//
//  ViewController.swift
//  CalendarProject
//
//  Created by user228274 on 10/23/22.
//

import UIKit

var selectedDate = Date()

class WeeklyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var tableView: UITableView!
    

    var totalSquares = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setCellsView()
        setWeekView()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 7 //7 rows
        let height = (collectionView.frame.size.height - 2) / 7 //7 columns
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setWeekView()
    {
        totalSquares.removeAll()
        
        var current = CalendarHelper().sundayForDate(date: selectedDate)
        let nextSunday = CalendarHelper().addDays(date: current, days: 7)
        
        while(current < nextSunday){
            totalSquares.append(current)
            current = CalendarHelper().addDays(date: current, days: 1)
        }
        
        
        //display Month year
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        
        let date = totalSquares[indexPath.item]
        cell.dayOfMonth.text = String(CalendarHelper().dayOfMonth(date: date))
        
        if(date == selectedDate)
        {
            cell.backgroundColor = UIColor.systemGreen

        }
        else{
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDate = totalSquares[indexPath.item]
        //print(selectedDate)
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    
    
    @IBAction func prevWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        //print(totalSquares.count)
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsforDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        let event = Event().eventsforDate(date: selectedDate)[indexPath.row]
        
        let str = CalendarHelper().timeString(date: event.date)
        
        let boldText = str
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = "   -   " + event.name
        let normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        
        cell.eventLabel.attributedText = attributedString
        
        
        //cell.eventLabel.text = event.name + " " + CalendarHelper().timeString(date: event.date)
        return cell
    }
    
    //swipe the row to delete events
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            eventsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ //wait 0.5s
            self.createAlert(title: "Deleted", msg: "Delete event succesfully")
        }
    }
    
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setWeekView()
    }

}


