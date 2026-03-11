# SwiftUI Flow Layout

![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS 16+](https://img.shields.io/badge/iOS-16%2B-blue.svg)
![SPM](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)
![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)

A flow layout (wrapping HStack) for SwiftUI — perfect for tags, chips, and badges. Built on the `Layout` protocol for native performance.

## Installation

```
https://github.com/tjdrhs90/swiftui-flow-layout.git
```

## Usage

### Tags

```swift
import FlowLayout

let tags = ["Swift", "SwiftUI", "iOS", "Xcode", "UIKit", "Combine", "SPM"]

FlowLayout(spacing: 8) {
    ForEach(tags, id: \.self) { tag in
        Text(tag)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(16)
    }
}
```

### Custom Spacing

```swift
FlowLayout(horizontalSpacing: 12, verticalSpacing: 8) {
    ForEach(items) { item in
        ChipView(item: item)
    }
}
```

### Styled Chips

```swift
FlowLayout(spacing: 8) {
    ForEach(filters, id: \.self) { filter in
        Text(filter)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(selectedFilters.contains(filter) ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(selectedFilters.contains(filter) ? .white : .primary)
            .cornerRadius(12)
            .onTapGesture { toggle(filter) }
    }
}
```

## Requirements

- iOS 16+ (uses the `Layout` protocol)
- Swift 5.9+
- Xcode 15+

## License

MIT License. See [LICENSE](LICENSE) for details.
