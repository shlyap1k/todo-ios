//
//  Router.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import UIKit

protocol Router {
    func push(to viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}
