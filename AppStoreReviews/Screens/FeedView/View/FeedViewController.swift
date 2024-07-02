//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

final class FeedViewController: UITableViewController {
    // MARK: - Private
    private var presentation: FeedPresentation? {
        didSet {
            feedDataSource?.applySnapshot(reviews: presentation?.reviews ?? [], animatingDifferences: false)
        }
    }

    private var topWords: String = "" {
        didSet {
            tableView.reloadData()
        }
    }

    private let starFilterControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All", "1⭐️", "2⭐️", "3⭐️", "4⭐️", "5⭐️"])
        control.selectedSegmentIndex = 0
        return control
    }()

    private var feedDataSource: FeedDataSource?

    // MARK: - Internal

    var viewModel: FeedViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDataSource()
        viewModel?.load()
    }

    private func setupViews() {
        navigationItem.titleView = starFilterControl
        tableView.translatesAutoresizingMaskIntoConstraints = false

        starFilterControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
    }

    private func setupDataSource() {
        feedDataSource = FeedDataSource(tableView: tableView)
    }

    @objc 
    private func filterChanged() {
        let selectedStars = starFilterControl.selectedSegmentIndex
        viewModel?.filterReviews(by: selectedStars)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return topWords
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let review = feedDataSource?.review(at: indexPath) {
            viewModel?.didTapReview(review)
        }
    }
}

// MARK: - FeedViewModelDelegate
extension FeedViewController: FeedViewModelDelegate {
    func handleViewModelOutput(_ output: FeedViewModelOutput) {
        switch output {
        case .showFeedData(let presentation):
            self.presentation = presentation

        case .showTopWords(let words):
            self.topWords = words
            tableView.reloadData()
        }
    }
}
