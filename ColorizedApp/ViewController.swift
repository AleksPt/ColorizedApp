import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var colorizedView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        redSlider.value = Float.random(in: 0...1)
        greenSlider.value = Float.random(in: 0...1)
        blueSlider.value = Float.random(in: 0...1)
        
        setupTextLabel()
        setupColorView(
            red: redSlider.value,
            green: greenSlider.value,
            blue: blueSlider.value
        )
    }
    
    @IBAction private func sliderActions(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            setupTextLabel()
            setupColorView(
                red: redSlider.value,
                green: greenSlider.value,
                blue: blueSlider.value
            )
        case 1:
            setupTextLabel()
            setupColorView(
                red: redSlider.value,
                green: greenSlider.value,
                blue: blueSlider.value
            )
        default:
            setupTextLabel()
            setupColorView(
                red: redSlider.value,
                green: greenSlider.value,
                blue: blueSlider.value
            )
        }
    }
    
    private func setupColorView(red: Float, green: Float, blue: Float) {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: 1
        )
    }
    
    private func setupTextLabel() {
        redValueLabel.text = String(format: "%.2f", redSlider.value)
        greenValueLabel.text = String(format: "%.2f", greenSlider.value)
        blueValueLabel.text = String(format: "%.2f", blueSlider.value)
    }
}

