import UIKit

class HalfSizePresentationSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate {

    override func perform() {
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = self
        source.navigationController?.present(destination, animated: true, completion: nil)
    }

    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfHeightPresentationController(presentedViewController: presented, presenting: presenting)
    }

}
