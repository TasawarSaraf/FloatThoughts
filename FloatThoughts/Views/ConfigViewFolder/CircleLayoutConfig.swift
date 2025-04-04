//
//  CircleLayoutConfig.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//

import SwiftUI

struct CircleLayoutConfig {
    static var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    static var isSmallPhone: Bool {
        UIScreen.main.bounds.height <= 667
    }

    static var numberOfCircles: Int {
        if isIpad {
            return 20
        } else if isSmallPhone {
            return 6
        } else {
            return 10
        }
    }

    static var width: CGFloat {
        if isIpad {
            return 100
        } else if isSmallPhone {
            return 60
        } else {
            return 80
        }
    }

    static var height: CGFloat {
        width
    }

    static var radius: CGFloat {
        if isIpad {
            return 80
        } else if isSmallPhone {
            return 25
        } else {
            return 50
        }
    }
    
    
    static let emoji: [String] = [
        "💭", "😊", "🌟", "❤️", "🧠", "🔥",
        "🌈", "✨", "😌", "💡", "🎨", "📚",
        "🌀", "🌞", "🌙", "🍃", "💫", "🎯",
        "🎵", "☁️", "🔮", "🕊️", "🧘‍♂️", "📖",
        "😇", "🫧", "🌸", "🫀", "🤍", "🌻"
    ]
}
