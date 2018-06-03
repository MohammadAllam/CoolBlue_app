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
    @IBOutlet weak var tableView: UITableView!

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
        viewModel = SearchViewModel()

        let inputs = viewModel.inputs
        let outputs = viewModel.outputs

        outputs.products
            .debug("Binding tableview")
            .bind(to: tableView.rx.items(cellIdentifier: "ProductCell")) {
                [unowned self](index, product: Product, cell:ProductTableViewCell) in
                cell.configureCell(with: self.viewModel.getCellViewModel(with: product))
            }
            .disposed(by: disposeBag)

        tableView.rx
            .contentOffset
            .flatMap { [unowned self] _ in
                return Observable.just(self.tableView.isNearTheBottomEdge())
            }
            .distinctUntilChanged()
            .skipUntil(outputs.isNewQuery)
            .bind(to: inputs.loadMore)
            .disposed(by: disposeBag)

        searchBar.rx
            .text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .debug("binding searchBar")
            .do(onNext: { _ in
                inputs.newQuery()
            })
            .bind(to: inputs.query)
            .disposed(by: disposeBag)
    }

    // MARK: UI
    func configureUI(){

        // Configuring dynamic table view cells height
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.accessibilityLabel = "SearchTable"
    }

    // MARK: Navigation
    @IBAction func unwindToSearchVC(segue:UIStoryboardSegue){

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow{
            let destinationVC = segue.destination as! ProductViewController
            destinationVC.setDisplayedProduct(with: viewModel.getProduct(atIndex: indexPath.row))
        }
    }
}

