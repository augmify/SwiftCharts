//
//  MasterViewController.swift
//  SwiftCharts
//
//  Created by ischuetz on 20/04/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit


enum Example {
    case HelloWorld, BarsV, BarsH, Areas, Coords, Target, Multival, Notifications, Combination, Scroll, EqualSpacing, Tracker, MultiAxis, MultiAxisInteractive, CandleStick, Cubiclines, NotNumeric, CandleStickInteractive, CustomUnits
}

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var examples: [(Example, String)] = [
        (.HelloWorld, "Hello World"),
        (.BarsV, "Veritical bars"),
        (.BarsH, "Horizontal bars"),
        (.Notifications, "Notifications (interactive)"),
        (.Target, "Target point animation"),
        (.Areas, "Areas, line, circles (interactive)"),
        (.Combination, "Bars, line, circles"),
        (.Scroll, "Multiline, Scroll"),
        (.Coords, "Show touch coords (interactive)"),
        (.Tracker, "Track touch (interactive)"),
        (.EqualSpacing, "Fixed axis spacing"),
        (.CustomUnits, "Custom units, rotated labels"),
        (.Multival, "Multiple axis labels"),
        (.MultiAxis, "Multiple axes"),
        (.MultiAxisInteractive, "Multiple axes (interactive)"),
        (.CandleStick, "Candlestick"),
        (.CandleStickInteractive, "Candlestick (interactive)"),
        (.Cubiclines, "Cubic lines"),
        (.NotNumeric, "Not numeric values")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Env.iPad {
            self.splitViewController?.toggleMasterView()
            self.performSegueWithIdentifier("showDetail", sender: self)
        }

        self.navigationController?.navigationBar.titleTextAttributes = ["NSFontAttributeName" : ExamplesDefaults.fontWithSize(22)]
        UIBarButtonItem.appearance().setTitleTextAttributes(["NSFontAttributeName" : ExamplesDefaults.fontWithSize(22)], forState: UIControlState.Normal)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            self.splitViewController?.toggleMasterView()
            
            func showExample(index: Int) {
                let example = self.examples[index]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = example.0
                controller.title = example.1
                
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                showExample(indexPath.row)
            } else {
                showExample(0)
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel!.text = examples[indexPath.row].1
        cell.textLabel!.font = ExamplesDefaults.fontWithSize(Env.iPad ? 22 : 16)
        return cell
    }
}

