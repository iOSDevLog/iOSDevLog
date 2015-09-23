//
//  ViewController.swift
//  Psychologist
//
//  Created by jiaxianhua on 15/9/23.
//  Copyright © 2015年 com.jiaxh. All rights reserved.
//

import UIKit

class PsychologistViewController
: UIViewController {
    @IBAction func nothing(sender: UIButton) {performSegueWithIdentifier("nothing", sender: nil)
    }
    
    // prepare for segues
    // the only segue we currently have is to the HappinessViewController
    // to show the Psychologist's diagnosis
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination = segue.destinationViewController
        // this next if-statement makes sure the segue prepares properly even
        //   if the MVC we're seguing to is wrapped in a UINavigationController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController!
        }
        if let hvc = destination as? HappinessViewController {
            if let identifier = segue.identifier {
                switch identifier {
                case "sad": hvc.happiness = 0
                case "happy": hvc.happiness = 100
                case "nothing": hvc.happiness = 25
                default: hvc.happiness = 50
                }
            }
        }
    }

}

