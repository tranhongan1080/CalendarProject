//
//  DailyViewController.swift
//  CalendarProject
//
//  Created by user228274 on 10/24/22.
//

import Foundation
import UIKit

class DailyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourTableView: UITableView!
    
    var hours = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTime()
    }
    
    func initTime(){
        for hour in 0...23{
            hours.append(hour)
        }
    }
    
    func setDayView(){
        dayLabel.text = CalendarHelper().monthDayString(date: selectedDate)
        dayOfWeekLabel.text = CalendarHelper().weekDayAsString(date: selectedDate)
        hourTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDailyID") as! DailyCell
        
        let hour = hours[indexPath.row]
        cell.time.text = formatHour(hour: hour)
        
        let events = Event().eventsforDateAndTime(date: selectedDate, hour: hour)
        setEvents(cell, events)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let actionSheetAlert = UIAlertController(title: "Options", message: "" , preferredStyle: .actionSheet)
        actionSheetAlert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {_ in
            
            self.createAlert(title: "Deleted", msg: "You have deleted the current event")
            }))
        actionSheetAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(actionSheetAlert, animated: true, completion: nil)

    }

    
    func setEvents(_ cell: DailyCell, _ events: [Event])
    {
        hideAll(cell)
        switch events.count{
        case 1:
            setEvent1(cell, events[0])
        case 2:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
        case 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setEvent3(cell, events[2])
        case let count where count > 3:
            setEvent1(cell, events[0])
            setEvent2(cell, events[1])
            setMoreEvents(cell, events.count - 2) //event 1 and 2
            
        default:
            break
        }
    }
    
    func setMoreEvents(_ cell: DailyCell, _ count: Int){
        cell.event3.isHidden = false
        cell.event3.text = String(count) + " More Events"
    }
    
    func setEvent1(_ cell: DailyCell, _ event: Event){
        cell.event1.isHidden = false
        cell.event1.text = event.name
    }
    
    func setEvent2(_ cell: DailyCell, _ event: Event){
        cell.event2.isHidden = false
        cell.event2.text = event.name
    }
    
    func setEvent3(_ cell: DailyCell, _ event: Event){
        cell.event3.isHidden = false
        cell.event3.text = event.name
    }
    
    func hideAll(_ cell: DailyCell){
        cell.event1.isHidden = true
        cell.event2.isHidden = true
        cell.event3.isHidden = true
    }
    
    func formatHour(hour: Int) -> String{
        return String(format: "%02d:%02d", hour, 0)
    }
    
    @IBAction func nextDay(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: 1)
        setDayView()
    }
    
    @IBAction func prevDay(_ sender: Any) {
        selectedDate = CalendarHelper().addDays(date: selectedDate, days: -1)
        setDayView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setDayView()
    }
    
    func createAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
}
