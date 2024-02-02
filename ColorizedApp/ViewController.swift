import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var colorizedView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    private var redColor: Float = 0
    private var greenColor: Float = 0
    private var blueColor: Float = 0
    
    @IBAction private func sliderActions(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redValueLabel.text = String(round(100 * sender.value) / 100)
            redColor = sender.value * 255
            setupColorView(red: redColor, green: greenColor, blue: blueColor)
        case 1:
            greenValueLabel.text = String(round(100 * sender.value) / 100)
            greenColor = sender.value * 255
            setupColorView(red: redColor, green: greenColor, blue: blueColor)
        default:
            blueValueLabel.text = String(round(100 * sender.value) / 100)
            blueColor = sender.value * 255
            setupColorView(red: redColor, green: greenColor, blue: blueColor)
        }
    }
    
    private func setupColorView(red: Float, green: Float, blue: Float) {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: 1
        )
    }
}

