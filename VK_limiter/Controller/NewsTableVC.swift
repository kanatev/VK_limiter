//
//  NewsTableVC.swift
//  VK_limiter
//
//  Created by Aleksei Kanatev on 02.05.2020.
//  Copyright © 2020 Aleksei Kanatev. All rights reserved.
//

import UIKit

class NewsTableVC: UITableViewController {

    @IBAction func exitButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private var selectedHearts = [IndexPath: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 100
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell

        if let state = selectedHearts[indexPath] {
            cell.heartFilled = state
        }
        cell.heartPressed = {[weak self] in
            self?.selectedHearts[indexPath] = cell.heartFilled
        }
        cell.cellIndexPath = indexPath
        cell.textOfNews.text = "Таиланд – государство в Юго-Восточной Азии с многочисленными тропическими пляжами, роскошными королевскими дворцами, древними руинами и богато украшенными буддийскими храмами."
        
        cell.imageForNews.image = UIImage(named: "tropic") ?? UIImage(named: "1no-img")
        
        cell.heightConstrPictureForNews.constant = getHeightForImage(widthOfCell: super.view.frame.width, width: cell.imageForNews.image!.size.width, height: cell.imageForNews.image!.size.height)

        return cell
    }
    
    
    func getHeightForImage(widthOfCell: CGFloat, width: CGFloat, height: CGFloat) -> CGFloat {
        let multiplier = height / width
        let newHeight = multiplier * widthOfCell
        return newHeight
    }
}

// убираем постоянное выделение ячейки
extension NewsTableVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
