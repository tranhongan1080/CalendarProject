//
//  ViewController.swift
//  CalendarProject
//
//  Created by user228274 on 10/23/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var today: UILabel!
   
    
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        today.text = " Today: \(CalendarHelper().monthDayString(date: Date())) "
        setCellsView()
        setMonthView()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 7 //7 rows
        let height = (collectionView.frame.size.height - 2) / 7 //7 columns
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        //present current date at the moment
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate) //total days
        
        //to identify which weekday is first day of the month
        let firstDayofMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayofMonth)
        
        var count: Int = 1
        
        //to fill out the view at the correct starting weekday of each month and where to stop at the end of each month
        while(count <= 42) //42 squares total for each calendar (7*6)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth){
                totalSquares.append("")
            }
            else{
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        //display Month year
        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        
        // Add star to the date indicating an event on this day
        for event in eventsList
        {
            if (getMonth(date: event.date) == getMonth(date: selectedDate)) {
                if (getDay(date: event.date) == String(totalSquares[indexPath.item]))
                {
                    //cell.backgroundColor = UIColor.systemGreen
                    cell.dayOfMonth.text = totalSquares[indexPath.item] + "*"
                }
            }
        }
        return cell
    }
    
    @IBAction func prevMonth(_ sender: Any) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        //print(totalSquares.count)
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setMonthView()
    }
    
    // Returns a list of all events for the current month
    func eventsForMonth() -> [Event]
    {
        var daysEvents = [Event]()
        
        for event in eventsList
        {
            if (getMonth(date: event.date) == getMonth(date: selectedDate)) {
                daysEvents.append(event)
            }
        }
        
        return daysEvents
    }
    
    // Returns the numeric month in the form of a string
    func getMonth(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M"
        let monthString = dateFormatter.string(from: date)
        
        return monthString
    }
    
    // Returns the day of the month in the form of a string
    func getDay(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let dayString = dateFormatter.string(from: date)
        
        
        return dayString
    }
}

