//
//  ChangeTableViewController.swift
//  230. Localizations
//
//  Created by iOS Dev Log on 2017/12/20.
//  Copyright © 2017年 iOSDevLog. All rights reserved.
//

import UIKit

class ChangeTableViewController: UITableViewController {
    
    @IBOutlet weak var testLabel: UILabel!
    var selectIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row != selectIndex {
            if let cell = tableView.cellForRow(at: IndexPath.init(row: selectIndex, section: 0)) {
                cell.accessoryType = .none
                if let tempCell = tableView.cellForRow(at: indexPath) {
                    tempCell.accessoryType = .checkmark
                    selectIndex = indexPath.row
                    changeLanguage()
                }
            }
        }
    }
    
    func changeLanguage() {
        let kTestKey = "testKey"
        
        switch selectIndex {
        case 0:
            testLabel.text = Bundle.loadLocalizableString(languageBundleName: Language.simplifiedChinese.rawValue, key: kTestKey)
            break
        case 1:
            testLabel.text = Bundle.loadLocalizableString(languageBundleName: Language.english.rawValue, key: kTestKey)
            break
        case 2:
            testLabel.text = Bundle.loadLocalizableString(languageBundleName: Language.japanese.rawValue, key: kTestKey)
            break
        case 3:
            testLabel.text = Bundle.loadLocalizableString(languageBundleName: Language.korea.rawValue, key: kTestKey)
            break
        default:
            break
        }
    }
}
