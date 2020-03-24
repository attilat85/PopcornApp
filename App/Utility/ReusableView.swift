//
//  ReusableView.swift
//  iOS Starter Project
//
//  Created by Halcyon Mobile on 07/02/2019.
//

import UIKit

/// Defines reusability behaviour
protocol ReusableView: class {
    static var reuseIdentifier: String { get }
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {

    /// Auto generated reuse identifier
    /// Same as the class name
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    /// Auto generated nib name
    /// Same as the class name
    static var nibName: String {
        return String(describing: self)
    }
}

// MARK: - UITableViewCell

extension UITableViewCell: ReusableView { }

// MARK: UITableViewHeaderFooterView

extension UITableViewHeaderFooterView: ReusableView { }

// MARK: - UITableView

extension UITableView {

    /// Register cell with the auto generated reuse identifier
    ///
    /// - Parameter cellType: cell class type
    final func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Register cell with the nib and the auto generated reuse identifier
    ///
    /// - Parameter cellType: cell class type
    final func registerWithNib<T: UITableViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Register header footer view with the auto generated reuse identifier
    ///
    /// - Parameter cellType: header class type
    final func registerHeader<T: UITableViewHeaderFooterView>(viewType: T.Type) {
        register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }

    /// Register header footer view with the nib and the auto generated reuse identifier
    ///
    /// - Parameter viewType: view class type
    final func registerHeaderWithNib<T: UITableViewHeaderFooterView>(viewType: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }

    /// Dequeue cell with type for a specific indexPath
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - cellType: cell class type
    /// - Returns: the reused cell
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }

    /// Dequeue header footer view with type for a specific indexPath
    ///
    /// - Parameter viewType: header view class type
    /// - Returns: the reused header view
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type = T.self) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T
    }
}

// MARK: - UITableViewCell

extension UICollectionViewCell: ReusableView { }

// MARK: - UICollectionView

extension UICollectionView {

    /// Register cell with the auto generated reuse identifier
    ///
    /// - Parameter cellType: cell class type
    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    /// Register cell with the nib and the auto generated reuse identifier
    ///
    /// - Parameter cellType: cell class type
    final func registerWithNib<T: UICollectionViewCell>(cellType: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    /// Dequeue cell with type for a specific indexPath
    ///
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - cellType: cell class type
    /// - Returns: the reused cell
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
}
