//
//  CodeDisplayView.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 7/10/18.
//  Copyright © 2018 Haptic Apps. All rights reserved.
//

import Anchorage
import reddift
import SDWebImage
import SwiftSpreadsheet
import Then
import TTTAttributedLabel
import UIKit
import XLActionController

class CodeDisplayView: UIScrollView {
    
    var baseData = [NSAttributedString]()
    var scrollView: UIScrollView!
    var widths = [CGFloat]()
    var baseColor: UIColor
    var baseLabel: UILabel
    var globalHeight: CGFloat
    
    init(baseHtml: String, color: UIColor) {
        self.baseColor = color
        globalHeight = CGFloat(0)
        baseLabel = UILabel()
        baseLabel.numberOfLines = 0
        super.init(frame: CGRect.zero)
        parseText(baseHtml.removingPercentEncoding ?? baseHtml)
        self.bounces = true
        self.isUserInteractionEnabled = true
        self.isScrollEnabled = true
        
        doData()
    }
    
    func parseText(_ text: String) {
        for string in text.split("\n") {
            if string.trimmed().isEmpty() {
                continue
            }
            do {
                let attr = try NSMutableAttributedString(data: string.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                let font = UIFont(name: "Courier", size: 16 + CGFloat(SettingValues.commentFontOffset)) ?? UIFont.systemFont(ofSize: 16)
                attr.addAttribute(NSFontAttributeName, value: font, range: NSRange.init(location: 0, length: attr.length))
                attr.addAttribute(NSForegroundColorAttributeName, value: baseColor, range: NSRange.init(location: 0, length: attr.length))
                let cell = LinkParser.parse(attr, baseColor)
                baseData.append(cell)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func doData() {
        widths.removeAll()
        for row in baseData {
            let framesetter = CTFramesetterCreateWithAttributedString(row)
            let textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(), nil, CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat(40)), nil)
            let length = textSize.width + 25
            widths.append(length)
        }
        addSubviews()
    }
    
    func addSubviews() {
        let finalString = NSMutableAttributedString.init()
        var index = 0
        for row in baseData {
            finalString.append(row)
            if index != baseData.count - 1 {
                finalString.append(NSAttributedString.init(string: "\n"))
            }
            index += 1
        }
        baseLabel.attributedText = finalString
        
        let framesetterB = CTFramesetterCreateWithAttributedString(finalString)
        let textSizeB = CTFramesetterSuggestFrameSizeWithConstraints(framesetterB, CFRange(), nil, CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), nil)

        addSubview(baseLabel)
        contentInset = UIEdgeInsets.init(top: 8, left: 8, bottom: 0, right: 8)
        baseLabel.widthAnchor == getWidestCell()
        globalHeight = textSizeB.height + 16
        baseLabel.heightAnchor == textSizeB.height
        baseLabel.leftAnchor == leftAnchor
        baseLabel.topAnchor == topAnchor
        contentSize = CGSize.init(width: getWidestCell() + 16, height: textSizeB.height)
    }
    
    func getWidestCell() -> CGFloat {
        var widest = CGFloat(0)
        for row in widths {
            if row > widest {
                widest = row
            }
        }
        return widest
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
