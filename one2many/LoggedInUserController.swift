import UIKit


class LoggedInUserController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let textCellIdentifier = "TextCell"
    
    var dummy = ["test array1", "test array2"]
    
    @IBOutlet weak var text: UILabel!
    
    
    var fire_ref = [String]()
    

    @IBAction func logout(sender: UIButton) {
        DataService.dataService.CURRENT_USER_REF.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        let loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("LogInScene")
        UIApplication.sharedApplication().keyWindow?.rootViewController = loginViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //** count users in firebase
        var count = 0
        DataService.dataService.USER_REF.observeEventType(.Value, withBlock: { snapshot in
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    count = count + 1
                    print(snap)
                }
            }
            self.text.text = "user count: \(count)"
        })

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = dummy[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(dummy[row])
    }
}

