//
//  ProductTableViewCell.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage

class ProductTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    // Header parameter
    @IBOutlet weak var view_header: UIView!
    @IBOutlet weak var constraint_headerHeight: NSLayoutConstraint!
    @IBOutlet weak var constraint_labelTop: NSLayoutConstraint!
    @IBOutlet weak var constraint_labelBottom: NSLayoutConstraint!
    @IBOutlet weak var constraint_borderHeight: NSLayoutConstraint!
    @IBOutlet weak var label_coolBlueTitle: UILabel!

    @IBOutlet weak var tableView_usp: UITableView!
    @IBOutlet weak var constraint_tableHeight: NSLayoutConstraint!

    @IBOutlet weak var label_productTitle: UILabel!
    @IBOutlet weak var constraint_titleHeight: NSLayoutConstraint!
    @IBOutlet weak var view_ratings: CosmosView!
    @IBOutlet weak var label_reviewsCount: UILabel!
    @IBOutlet weak var label_oldPrice: UILabel!
    @IBOutlet weak var label_newPrice: UILabel!
    @IBOutlet weak var label_avialbleTomorrow: UILabel!
    @IBOutlet weak var imageView_thumbnail: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Private
    private var productCellVM:ProductCellViewModel!
    private var observation: NSKeyValueObservation?

    override func awakeFromNib() {
        super.awakeFromNib()

        //Configuring the tableview
        tableView.dataSource = self
        tableView.estimatedRowHeight = 23
        tableView.rowHeight = UITableViewAutomaticDimension
        //Configuring rating view
        view_ratings.settings.fillMode = .half
        //Resetting all values in the controls to avoid displaying old data
        resetControls()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        //Resetting all values in the controls to avoid displaying old data
        resetControls()
    }

    func resetControls(){
        self.label_coolBlueTitle.text = ""
        self.label_productTitle.text = ""
        self.label_reviewsCount.text = ""
        self.label_oldPrice.text = ""
        self.label_newPrice.text = ""
        self.view_ratings.rating = 0
        self.imageView_thumbnail.image = nil
    }

    func configureCell(with cellViewModel:ProductCellViewModel){

        productCellVM = cellViewModel
        // Configuring the header
        if let cbTitle = productCellVM.coolBlueTitle{
            constraint_headerHeight.isActive = false
            constraint_labelTop.isActive = true
            //            constraint_labelBottom.isActive = true
            //            constraint_borderHeight.isActive = true
            view_header.isHidden = false
            label_coolBlueTitle.text = cbTitle
        }
        else{
            constraint_labelTop.isActive = false
            //            constraint_labelBottom.isActive = false
            //            constraint_borderHeight.isActive = false
            constraint_headerHeight.isActive = true
            view_header.isHidden = true
        }
        // Configuring the title
        label_productTitle.text = productCellVM.title
        constraint_titleHeight.constant = productCellVM.title.height(withConstrainedWidth: label_productTitle.frame.width,
                                                                     font: label_productTitle.font)
        // Configuring the rating view
        view_ratings.rating = productCellVM.reviewAvg
        // Configuring the rating count
        label_reviewsCount.text = productCellVM.reviewCount
        // Configuring the USEPs
        var totalTableHeight:CGFloat = 0
        productCellVM.usp.forEach { usp in

            totalTableHeight += usp.height(withConstrainedWidth: tableView.frame.size.width,
                                           font: UIFont.systemFont(ofSize:11.0))
            totalTableHeight += 10 //Spaces Constant value
        }
        self.constraint_tableHeight.constant = totalTableHeight
        tableView.reloadData()
        // Configuring the old price
        if let oldPrice = productCellVM.oldPrice {
            label_oldPrice.text = oldPrice
        }else{

        }
        // Configuring the new price
        label_newPrice.text = productCellVM.newPrice
        // Configuring the next day delivery flag
        label_avialbleTomorrow.isHidden = !productCellVM.nextDayDeliveryFlag
        // Configuring the thumbnail
        if let thumbnailURL = URL(string:productCellVM.thumbnail!){
            imageView_thumbnail.af_setImage(withURL: thumbnailURL)
        }
        else{
            imageView_thumbnail.image = Image(named: "DefaultThumbnail")
        }
        layoutIfNeeded()
    }
}

extension ProductTableViewCell:UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        return productCellVM.usp.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "uspCell",
                                                 for: indexPath) as! USPTableViewCell

        cell.label_text.text = productCellVM.usp[indexPath.row]

        return cell
    }

}

