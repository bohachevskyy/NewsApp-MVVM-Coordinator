//
//  UIScrollView+ScrollPosition.swift
//  NewsApp
//
//  Created by Dmytro Bohachevskyi on 10/3/19.
//  Copyright © 2019 Dmytro Bohachevskyi. All rights reserved.
//

import UIKit

extension UIScrollView {
    func hasScrolledToBottom(padding: CGFloat = 0) -> Bool {
        let effectiveFrameHeight = frame.size.height - adjustedContentInset.top - adjustedContentInset.bottom
        let yOffset = contentOffset.y + adjustedContentInset.top
        let disatnceFromBottom = contentSize.height - yOffset
        
        return disatnceFromBottom - effectiveFrameHeight < padding
    }
}
