//
//  ViewController.swift
//  AppEventCount
//
//  Created by Devere Weaver on 12/24/23.
//

import UIKit

class ViewController: UIViewController {

    // App Delegate Labels
    @IBOutlet var didFinishLaunchedLabel: UILabel!
    @IBOutlet var configurationForConnectingLabel: UILabel!
    
    // access the AppDelegate class and its count variables in this ViewController and
    // do it here because we only really want AppDelegate business in the AppDelegate
    var appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    // Scene Delegate Labels
    @IBOutlet var willConnectToLabel: UILabel!
    @IBOutlet var didBecomeActiveLabel: UILabel!
    @IBOutlet var willResignActiveLabel: UILabel!
    @IBOutlet var willEnterForgroundLabel: UILabel!
    @IBOutlet var didEnterBackgroundLabel: UILabel!
    
    // Count the number of times a scene delegate method has been called
    var willConnectToCount = 0
    var didBecomeActiveCount = 0
    var willResignActiveCount = 0
    var willEnterForgroundCount = 0
    var didEnterBackgroundCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        updateView()
    }
    
    func updateView() {
        /* Update each label with its counts */
        didFinishLaunchedLabel.text = "The App has launched \(appDelegate.launchCount) time(s)"
        configurationForConnectingLabel.text = "The App has configured \(appDelegate.configurationForConnectingCount) connection(s)"
        willConnectToLabel.text = "The App has connected to \(willConnectToCount) scence(s)"
        didBecomeActiveLabel.text = "The scene has become active \(didBecomeActiveCount) time(s)"
        willResignActiveLabel.text = "The scene will resign \(willResignActiveCount) time(s)"
        willEnterForgroundLabel.text = "The scene entered the foreground \(willEnterForgroundCount) time(s)"
        didEnterBackgroundLabel.text = "The scene entered the background \(didEnterBackgroundCount) time(s)"
    }

}
