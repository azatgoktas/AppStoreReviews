//
//  FeedDataSource.swift
//  AppStoreReviews
//
//  Created by Azat Goktas on 02/07/2024.
//  Copyright © 2024 ING. All rights reserved.
//

import Foundation
import UIKit

final class FeedDataSource {
    // MARK: - Private
    private let tableView: UITableView
    private var dataSource: UITableViewDiffableDataSource<Int, Review>?

    private enum Constants {
        static let rowHeight: CGFloat = 160
    }

    init(tableView: UITableView) {
        self.tableView = tableView
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "cellId")
        tableView.rowHeight = Constants.rowHeight
        setupDataSource()
    }

    func applySnapshot(reviews: [Review], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Review>()
        snapshot.appendSections([0])
        snapshot.appendItems(reviews)
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func review(at indexPath: IndexPath) -> Review? {
        return dataSource?.itemIdentifier(for: indexPath)
    }

    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, Review>(tableView: tableView) { tableView, indexPath, review in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ReviewCell
            cell.update(item: review)
            return cell
        }
        tableView.dataSource = dataSource
    }
}
