//
//  CreatePostTitleAndDescriptionDelegate.swift
//  RioFatos
//
//  Created by Bruno Baring on 14/07/17.
//  Copyright © 2017 Bruno Baring. All rights reserved.
//

import Foundation
import UIKit

class CreatePostTitleAndDescriptionDelegate: NSObject
{
    
    var delegate: CreatePostController! = nil
    let textFieldPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15);

    func getCorrectCharLeftQty(qtyMax: Int, qtyCurrent: Int, string: String) -> (Bool, Int)
    {
        let charLeft = qtyMax - qtyCurrent
        if charLeft >= 1 && string != ""
        {
            return (true, charLeft - 1)
        }
        else if charLeft >= -1 && string == ""
        {
            return (true, charLeft + 1)
        }
        return (false, charLeft)
    }
    
}

extension CreatePostTitleAndDescriptionDelegate: UITextFieldDelegate
{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let charLeft = getCorrectCharLeftQty(qtyMax: Environment.sharedInstance.titleCharLeftQtyMax,
                                             qtyCurrent: textField.text!.characters.count, string: string)
        delegate.newTitleCharQty(charLeft.1)
        return charLeft.0
    }
    
    //--------------  PADDING  --------------
    
    func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textFieldPadding)
    }
    
    func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textFieldPadding)
    }
    
    func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, textFieldPadding)
    }
    
}

extension CreatePostTitleAndDescriptionDelegate: UITextViewDelegate
{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text.characters.count == 0 && text == ""
        {
            return false
        }
        
        let charLeft = getCorrectCharLeftQty(qtyMax: Environment.sharedInstance.descriptionCharLeftQtyMax,
                                             qtyCurrent: textView.text!.characters.count, string: text)
        delegate.newDescriptionCharQty(charLeft.1)
        return charLeft.0

    }
    
}
