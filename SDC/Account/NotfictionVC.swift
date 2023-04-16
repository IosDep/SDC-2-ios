//
//  NotfictionVC.swift
//  SDC
//
//  Created by Blue Ray on 26/03/2023.
//

import UIKit

class NotfictionVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var notficationTable:UITableView!
    @IBOutlet weak var mainView:UIView!
    @IBOutlet weak var bellView:UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

    
        
        notficationTable.dataSource = self
        notficationTable.delegate = self
        
        notficationTable.register(UINib(nibName: "NotficationXIB", bundle: nil), forCellReuseIdentifier: "NotficationXIB")
        self.cerateBellView(bellview: self.bellView, count: "12")
        
        mainView.roundCorners([.topRight,.topLeft], radius: 18)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.notficationTable.dequeueReusableCell(withIdentifier: "NotficationXIB", for: indexPath) as? NotficationXIB
      
        
        
        
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("NotficationXIB", owner: self, options: nil)!
            cell = nib[0] as? NotficationXIB
        }
        
//        self.makeShadow(mainView: cell?.mainCardView)
//        self.makeShadow(mainView: cell!.contentView)
//        cell?.mainCardView.layer.cornerRadius = 10
//        cell?.mainCardView.clipsToBounds = true
//        cell?.mainCardView.layer.borderWidth = 0
//        cell?.mainCardView.layer.shadowColor = UIColor.black.cgColor
//        cell?.mainCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        cell?.mainCardView.layer.shadowRadius = 5
//        cell?.mainCardView.layer.shadowOpacity = 0.2
//        cell?.mainCardView.layer.masksToBounds = false
        
        
        return cell!
    }

//    override func viewDidAppear(_ animated: Bool) {
//        self.setupSideMenu()
//
//    }
}
