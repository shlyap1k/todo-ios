//
//  RouterImpl.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import UIKit

final class RouterImpl: Router {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(to viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
