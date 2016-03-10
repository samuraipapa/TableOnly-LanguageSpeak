//
//  MasterViewController.swift
//  TableView-MasterDetail-Lang-Examp
//
//  Created by GrownYoda on 12/3/15.
//  Copyright © 2015 YuryG. All rights reserved.
//

import UIKit
import AVFoundation


class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    // MARK: - ViewController Class-Wide Variables
    // MARK: Speach Related
    let mySpeechSynth = AVSpeechSynthesizer()
    var myRate: Float = 0.50
    var myPitch: Float = 1.15
    var myVolume: Float = 0.92
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speakThisString("yes, and.")
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
   //     let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
   //     self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insert(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
//        }
//    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
       
        let position = indexPath.row + 1

        print("selected indexPath.row \(position)"  + langCodeAll38[indexPath.row].3)
        currentLang = langCodeAll38[position]
        print("chanted currentLang to  \(langCodeAll38[position])")

        speakThisString(currentLang.3)

        print("Spoke String  \(currentLang.3)")

    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langCodeAll38.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //  let object = objects[indexPath.row] as! NSDate
        
        let object1 = langCodeAll38[indexPath.row].1
        let object2 = "\(langCodeAll38[indexPath.row].4) \(langCodeAll38[indexPath.row].3)"
        
        
        cell.textLabel!.text = object2
        cell.detailTextLabel?.text = object1
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //MARK: - Data Model
    
    // current lang array has known typos, to fix in future.
    var langCodeAll38 = [
        
        // English
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),


        //French
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        
        //Spanish
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),

        //Dutch
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),


        
        //Eurasia-ish
        ("el-GR",      "Modern Greek",        "Greece","ελληνική","🇬🇷"),
        ("it-IT",       "Italian",     "Italy", "Italiano","🇮🇹"),


        ("ru-RU",       "Russian",     "Russian Federation","русский","🇷🇺"),
        ("cs-CZ", "Czech", "Czech Republic","český","🇨🇿"),
        ("sk-SK",       "Slovak",      "Slovakia", "Slovenčina","🇸🇰"),
        ("pl-PL",       "Polish",      "Poland", "Polski","🇵🇱"),

        ("da-DK", "Danish","Denmark","Dansk","🇩🇰"),
        ("sv-SE",       "Swedish",     "Sweden","Svenska","🇸🇪"),
        ("fi-FI",       "Finnish",     "Finland","Suomi","🇫🇮"),
        ("no-NO",       "Norwegian",    "Norway", "Norsk","🇳🇴"),
        ("de-DE",       "German", "Germany", "Deutsche","🇩🇪"),

        ("ro-RO",       "Romanian",        "Romania","Română","🇷🇴"),
        ("hu-HU",       "Hungarian",    "Hungary", "Magyar","🇭🇺"),

        ("tr-TR",       "Turkish",     "Turkey","Türkçe","🇹🇷"),


        
        
        //East & Middle East
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
    

        // Pacific Rim
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("id-ID",       "Indonesian",    "Indonesia", "Bahasa Indonesia","🇮🇩"),
        
        
        // Portuguese
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        
        // Chinese
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
    ]
    
    
    
    
    //MARK: - Speaking Machine
    
    func speakThisString(passedString: String){
        
        mySpeechSynth.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        let myUtterance = AVSpeechUtterance(string: passedString)
        myUtterance.rate = myRate
        myUtterance.pitchMultiplier = myPitch
        myUtterance.volume = myVolume
        myUtterance.voice = AVSpeechSynthesisVoice(language: currentLang.0)
        mySpeechSynth.speakUtterance(myUtterance)
        
        
        
    }

    
}


