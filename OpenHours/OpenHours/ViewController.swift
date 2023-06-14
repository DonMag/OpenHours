//
//  ViewController.swift
//  OpenHours
//
//  Created by Don Mag on 6/14/23.
//

import UIKit

struct VenueStruct {
	// assuming there are some other properties
	var venueName: String = "Some Venue"
	var venueAddress: String = "123 Main Street"
	// etc...
	
	// array of operating hours
	//	this will be filled with 7 [String] arrays (one for each day of the week)
	//	each of those arrays will have 1 or more time ranges
	var hoursArray: [[String]] = []
}

class StackHoursCell: UITableViewCell {
	
	@IBOutlet var outerStackView: UIStackView!
	
	public func fillTheData(_ venue: VenueStruct) {
		// make sure we have valid data
		guard venue.hoursArray.count == 7 else {
			fatalError("Hours Array does not have 7 elements!")
		}
		var str: String = ""
		var row: Int = 0
		venue.hoursArray.forEach { a in
			// always safely unwrap optionals
			if let rowStack = outerStackView.arrangedSubviews[row] as? UIStackView {
				guard rowStack.arrangedSubviews.count == 2 else {
					fatalError("Bad setup... row stack views must have two arranged subviews!")
				}
				if let v2 = rowStack.arrangedSubviews[1] as? UILabel {
					str = ""
					a.forEach { hStr in
						str += hStr
						if hStr != a.last {
							str += "\n"
						}
					}
					v2.text = str
				}
			}
			row += 1
		}
	}

}

class SampleTableViewController: UITableViewController {
		
	var myData: [VenueStruct] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// let's get some sample data
		myData = SampleVenueData().sampleData()
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return myData.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let c = tableView.dequeueReusableCell(withIdentifier: "StackHoursCell", for: indexPath) as! StackHoursCell
		c.fillTheData(myData[indexPath.row])
		return c
	}
	
}

class SampleVenueData: NSObject {
	
	// various hours strings... just to make it easier
	//	to generate some sample data
	func hoursString(_ s: String) -> String {
		var str = ""
		switch s {
		case "11to10":
			str = "11:00 am - 10:00 pm"
		case "7to11":
			str = "7:00 am - 11:00 am"
		case "12to10":
			str = "12:00 pm - 10:00 pm"
		case "10to10":
			str = "10:00 am - 10:00 pm"
		case "12to4":
			str = "12:00 pm - 4:00 pm"
		case "5to10":
			str = "5:00 pm - 10:00 pm"
		default:
			str = "24 Hours"
		}
		return str
	}
	
	func sampleData() -> [VenueStruct] {
		
		var venueData: [VenueStruct] = []
		
		// some sample data
		var v: VenueStruct!
		
		v = VenueStruct()
		v.hoursArray = []
		for _ in 0..<7 {
			v.hoursArray.append([hoursString("11to10")])
		}
		venueData.append(v)
		
		v = VenueStruct()
		v.hoursArray = []
		
		v.hoursArray.append([hoursString("7to11"), hoursString("12to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("7to11"), hoursString("12to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		
		venueData.append(v)
		
		v = VenueStruct()
		v.hoursArray = []
		
		v.hoursArray.append([hoursString("7to11"), hoursString("12to4"), hoursString("5to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("7to11"), hoursString("12to4"), hoursString("5to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		
		venueData.append(v)
		
		v = VenueStruct()
		v.hoursArray = []
		
		v.hoursArray.append([hoursString("7to11"), hoursString("5to10")])
		v.hoursArray.append([hoursString("7to11"), hoursString("5to10")])
		v.hoursArray.append([hoursString("7to11"), hoursString("12to4"), hoursString("5to10")])
		v.hoursArray.append([hoursString("7to11"), hoursString("5to10")])
		v.hoursArray.append([hoursString("7to11"), hoursString("12to4"), hoursString("5to10")])
		v.hoursArray.append([hoursString("10to10")])
		v.hoursArray.append([hoursString("10to10")])
		
		venueData.append(v)
		
		// replicate it a few times to confirm scrolling works
		venueData.append(contentsOf: venueData)
		venueData.append(contentsOf: venueData)
		
		return venueData
	}
	
}
