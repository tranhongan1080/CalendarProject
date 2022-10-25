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
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    
    
    @IBAction func prevWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -7)
        setWeekView()
    }
    
    @IBAction func nextWeek(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 7)
        setWeekView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Event().eventsforDate(date: selectedDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as! EventCell
        let event = Event().eventsforDate(date: selectedDate)[indexPath.row]
        cell.eventLabel.text = event.name + " " + CalendarHelper().timetring(date: event.date)
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

}


