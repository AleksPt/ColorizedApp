import UIKit

protocol SetColorViewControllerDelegate: AnyObject {
    func setBackgroundColor(_ color: UIColor)
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setColorVC = segue.destination as? SetColorViewController
        setColorVC?.delegate = self
    }
}

extension ViewController: SetColorViewControllerDelegate {
    func setBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
