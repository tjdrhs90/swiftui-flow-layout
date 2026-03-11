import SwiftUI

/// A layout that arranges its children horizontally, wrapping to the next line when needed.
@available(iOS 16.0, *)
public struct FlowLayout: Layout {
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat

    public init(spacing: CGFloat = 8) {
        self.horizontalSpacing = spacing
        self.verticalSpacing = spacing
    }

    public init(horizontalSpacing: CGFloat, verticalSpacing: CGFloat) {
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
    }

    public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var height: CGFloat = 0
        var width: CGFloat = 0

        for (index, row) in rows.enumerated() {
            let rowHeight = row.map { $0.height }.max() ?? 0
            height += rowHeight
            if index < rows.count - 1 {
                height += verticalSpacing
            }
            let rowWidth = row.map { $0.width }.reduce(CGFloat(0)) { $0 + $1 }
                + CGFloat(max(0, row.count - 1)) * horizontalSpacing
            width = max(width, rowWidth)
        }

        return CGSize(width: width, height: height)
    }

    public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY

        for row in rows {
            let rowHeight = row.map { $0.height }.max() ?? 0
            var x = bounds.minX

            for size in row {
                let index = row.firstIndex(where: { $0 == size })!
                let subviewIndex = rows.prefix(while: { $0 != row }).map(\.count).reduce(0, +) + index
                subviews[subviewIndex].place(
                    at: CGPoint(x: x, y: y),
                    proposal: ProposedViewSize(size)
                )
                x += size.width + horizontalSpacing
            }

            y += rowHeight + verticalSpacing
        }
    }

    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [[CGSize]] {
        let maxWidth = proposal.width ?? .infinity
        var rows: [[CGSize]] = [[]]
        var currentRowWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentRowWidth + size.width + horizontalSpacing > maxWidth, !rows[rows.count - 1].isEmpty {
                rows.append([])
                currentRowWidth = 0
            }

            rows[rows.count - 1].append(size)
            currentRowWidth += size.width + horizontalSpacing
        }

        return rows
    }
}

// MARK: - CGSize Equatable conformance helper

private extension Array where Element == CGSize {
    static func != (lhs: Self, rhs: Self) -> Bool {
        guard lhs.count == rhs.count else { return true }
        for (a, b) in zip(lhs, rhs) {
            if a.width != b.width || a.height != b.height { return true }
        }
        return false
    }
}
