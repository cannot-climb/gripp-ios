//
//  CustomRangeSeekSlider.swift
//  RangeSeekSlider
//
//  Created by Keisuke Shoji on 2017/03/16.
//
//

import UIKit
import RangeSeekSlider

@IBDesignable final class CustomRangeSeekSlider: RangeSeekSlider {


    override func setupStyle() {
        let accent: UIColor = UIColor(named: "AccentMasterColor")!
        let base: UIColor = UIColor(named: "BackgroundMasterColor")!

        minValue = 0
        maxValue = 19
        handleColor = accent
        minLabelColor = accent
        maxLabelColor = accent
        colorBetweenHandles = accent
        tintColor = base
        handleDiameter = 24
        lineHeight = 10
        
        enableStep = true
        step = 1
        handleColor = .white
    }

    fileprivate func formatter(value: CGFloat) -> String {
        return "V\(numberFormatter.string(from: value as NSNumber)!)"
    }
}


// MARK: - RangeSeekSliderDelegate

extension CustomRangeSeekSlider: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        return formatter(value: minValue)
    }

    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        return formatter(value: maxValue)
    }
}
