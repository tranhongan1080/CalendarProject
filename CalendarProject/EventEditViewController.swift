//
//  EventEditViewController.swift
//  CalendarProject
//
//  Created by user228274 on 10/24/22.
//

import UIKit

class EventEditViewController: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var schedule: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        schedule.date = selectedDate
    }
    
    @IBAction func saveBtn(_ sender: Any){
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = name.text
        newEvent.date = schedule.date
        
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
