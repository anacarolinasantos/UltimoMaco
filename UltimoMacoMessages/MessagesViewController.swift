//
//  MessagesViewController.swift
//  UltimoMacoMessages
//
//  Created by Guilherme Paciulli on 15/02/18.
//  Copyright © 2018 Guilherme Paciulli. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, SendMessage {
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        self.presentViewController(withPresentation: presentationStyle)
    }
    
    func presentViewController(withPresentation style: MSMessagesAppPresentationStyle) {
        let controller = self.instantiateViewController(with: style)
        self.childViewControllers.forEach({ $0.removeFromParentViewController() })
        self.addChildViewController(controller)
        if let expandedController = controller as? ExpandedChartViewController {
            expandedController.delegate = self
        }
        self.view.addSubview(controller.view)
        controller.view.frame = self.view.bounds
        controller.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        controller.didMove(toParentViewController: self)
    }
    
    func instantiateViewController(with style: MSMessagesAppPresentationStyle) -> UIViewController {
        let identifier: ViewControllerIdentifier = style == .compact ? .compact : .expanded
        return self.storyboard!.instantiateViewController(withIdentifier: identifier.rawValue)
    }
    
    @IBAction func shareChartButtonClicked(_ sender: Any) {
        self.requestPresentationStyle(.expanded)
    }
    
    func didSendChart(on image: UIImage) {
        if let conversation = self.activeConversation {
            let layout = MSMessageTemplateLayout()
            layout.image = image
            layout.caption = "Meu progresso em parar de fumar!"
            
            let message = MSMessage()
            message.layout = layout
            
            conversation.insert(message, completionHandler: nil)
        }
        
        requestPresentationStyle(.compact)
    }
    

}

enum ViewControllerIdentifier: String {
    case compact = "compactChartViewController"
    case expanded = "expandedChartViewController"
}
