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
    
    
    //MARK: - Data Model     Stored Properties
    
    let tableViewCellIdentifier = "TableViewCellIdentifier"
    
    let langCatagories : [String] = ["Western","Central European","Middle Eastern","Eastern"]
    
    var myLangDictionary : [String:[(String,String,String,String, String)]] = Dictionary()
    

    // Western Languagues
    
    let westerLangs = [
        
        // English
        
        ("en-US",  "English", "United States", "American English","🇺🇸"),
        ("en-AU",     "English",     "Australia","Aussie","🇦🇺"),
        ("en-GB",     "English",     "United Kingdom", "Queen's English","🇬🇧"),
        ("en-IE",      "English",     "Ireland", "Gaeilge","🇮🇪"),
        ("en-ZA",       "English",     "South Africa", "South African English","🇿🇦"),
        
        
        //Spanish
        ("es-ES",       "Spanish",     "Spain", "Español","🇪🇸"),
        ("es-MX",       "Spanish",     "Mexico", "Español de México","🇲🇽"),
        
        
        //French
        ("fr-CA",       "French",      "Canada","Français du Canada","🇨🇦" ),
        ("fr-FR",       "French",      "France", "Français","🇫🇷"),
        
        
        // Portuguese
        ("pt-BR",       "Portuguese",      "Brazil","Portuguese","🇧🇷"),
        ("pt-PT",       "Portuguese",      "Portugal","Portuguese","🇵🇹"),
        ("th-TH",       "Thai",        "Thailand","ภาษาไทย","🇹🇭"),
        
        
        //Dutch
        ("nl-BE",       "Dutch",       "Belgium","Nederlandse","🇧🇪"),
        ("nl-NL",       "Dutch",       "Netherlands", "Nederlands","🇳🇱"),
        
    ]
    
    let CenteralEastEULangs = [
        
        // English
        
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
        
    ]
    
    
    
    let middleEastLangs = [
        //Eurasia-ish
        
        //East & Middle East
        ("hi-IN",       "Hindi",       "India", "हिन्दी","🇮🇳"),
        ("he-IL",       "Hebrew",      "Israel","עברית","🇮🇱"),
        ("ar-SA","Arabic","Saudi Arabia","العربية","🇸🇦"),
        
        
    ]
    
    let easternLangs = [
        
        // Pacific Rim
        ("ja-JP",       "Japanese",     "Japan", "日本語","🇯🇵"),
        ("ko-KR",       "Korean",      "Republic of Korea", "한국어","🇰🇷"),
        ("id-ID",       "Indonesian",    "Indonesia", "Bahasa Indonesia","🇮🇩"),
        
        
        
        // Chinese
        ("zh-CN",       "Chinese",     "China","漢語/汉语","🇨🇳"),
        ("zh-HK",       "Chinese",   "Hong Kong","漢語/汉语","🇭🇰"),
        ("zh-TW",       "Chinese",     "Taiwan","漢語/汉语","🇹🇼")
        
    ]
    
    

    
    
    
    
    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    // MARK: - ViewController Class-Wide Variables
    // MARK: Speach Related
    let mySpeechSynth = AVSpeechSynthesizer()
    var myRate: Float = 0.50
    var myPitch: Float = 1.15
    var myVolume: Float = 0.92
    var currentLang = ("en-US", "English","United States","American English ","🇺🇸")
    
    
    
    func helperDictionaryMaker(){
        
        
        myLangDictionary["Western"] = westerLangs
        myLangDictionary["Central European"] = CenteralEastEULangs
        myLangDictionary["Middle Eastern"] = middleEastLangs
        myLangDictionary["Eastern"] = easternLangs
        // myLangDictionary["Central European"]
        
        print("made dictionary: \(myLangDictionary)")
    }

    
    // MARK: - UIViewController Methods

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        speakThisString("yes, and.")
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
       
        let mySection = indexPath.section
        let innerRow = indexPath.row
        
        print("selected section \(mySection)"  + "innerRow \(innerRow)")
        
        switch (mySection) {
            
        case 0:
            break;
        case 1:
           currentLang = westerLangs[innerRow]
            break;
            
        case 2:
            currentLang = CenteralEastEULangs[innerRow]
            break;
            
        case 3:
            currentLang = middleEastLangs[innerRow]
            break;
            
        case 4:
            currentLang = easternLangs[innerRow]
            break;
            
            
        default:

        speakThisString(currentLang.3)
    }
        speakThisString(currentLang.3)
        
    
    }
    

    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var  headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! CustomHeaderCell
//        headerCell.backgroundColor = UIColor.cyanColor()
//        
//        switch (section) {
//        case 0:
//            headerCell.headerLabel.text = "Europe";
//            //return sectionHeaderView
//        case 1:
//            headerCell.headerLabel.text = "Asia";
//            //return sectionHeaderView
//        case 2:
//            headerCell.headerLabel.text = "South America";
//            //return sectionHeaderView
//        default:
//            headerCell.headerLabel.text = "Other";
//        }
//        
//        return headerCell
//    }
//    
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return westerLangs.count
            
            
        }
        else if section == 2{ return westerLangs.count
            } else if section == 3{ return westerLangs.count
                } else if section == 4{ return westerLangs.count
                    }
    
        return 1
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //  let object = objects[indexPath.row] as! NSDate
        
        let mySection = indexPath.section
        let innerRow = indexPath.row
        
        switch (mySection) {
            
        case 0:
            break;
  case 1:
    cell.textLabel!.text = westerLangs[innerRow].1
    cell.detailTextLabel?.text = " \(westerLangs[innerRow].4)  \(westerLangs[innerRow].2)  "
    break;

    case 2:
            cell.textLabel!.text = CenteralEastEULangs[innerRow].1
            cell.detailTextLabel?.text = " \(CenteralEastEULangs[innerRow].4)  \(CenteralEastEULangs[innerRow].2)  "
            break;
            
        case 3:
            cell.textLabel!.text = middleEastLangs[innerRow].1
            cell.detailTextLabel?.text = " \(middleEastLangs[innerRow].4)  \(middleEastLangs[innerRow].2)  "
            break;
            
        case 4:
            cell.textLabel!.text = easternLangs[innerRow].1
            cell.detailTextLabel?.text = " \(easternLangs[innerRow].4)  \(easternLangs[innerRow].2)  "
            break;

            
  default:
    
    cell.textLabel!.text = "default"
    cell.detailTextLabel?.text = "default"

    
    break;
}
        

        
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

    // MARK: UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let mySection = section
        
        var myTitle = langCatagories[mySection]
        
        return myTitle
    }

    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.orangeColor()
        headerView.textLabel?.font = UIFont(name: "Avenir Next", size: 25.0)
    }
    
    // MARK: - Helper Methods
    
    func makeDictionary(){
        
    }

}


