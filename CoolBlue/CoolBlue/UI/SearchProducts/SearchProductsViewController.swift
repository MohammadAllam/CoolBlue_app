//
//  SearchProductsViewController.swift
//  CoolBlue
//
//  Created by Mohammad Allam on 6/3/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchProductsViewController: UIViewController {

    // MARK: ViewModel
    private var viewModel:SearchViewModel!

    // MARK: IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!

    // MARK: Private
    private var disposeBag = DisposeBag()

    // MARK: Overrider
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
        configureUI()
    }

    // MARK: Binding
    func configureViewModel() {
        viewModel = SearchViewModel(disposeBag: disposeBag)

        let inputs = viewModel.inputs
        let outputs = viewModel.outputs

        outputs.products
            .debug("Binding tableview")
            .bind(to: tableview.rx.items(cellIdentifier: "ProductCell")) {
                (index, inputString: String, cell:UITableViewCell) in
                cell.textLabel?.text = inputString
            }
            .disposed(by: disposeBag)

        searchBar.rx
            .text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .debug("binding searchBar")
            .bind(to: inputs.query)
            .disposed(by: disposeBag)
    }

    // MARK: UI
    func configureUI(){

        // Configuring dynamic table view cells height
        tableview.estimatedRowHeight = 40
        tableview.rowHeight = UITableViewAutomaticDimension
    }
}

