import UIKit

class HalfHeightPresentationController: UIPresentationController {

    override var shouldPresentInFullscreen: Bool {
        return false
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else {
            return .zero
        }

        let size = containerView.bounds
        let computedHeight = size.height / 2

        return CGRect(x: 0, y: size.height - computedHeight, width: size.width, height: computedHeight)
    }

}
