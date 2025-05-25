import UIKit
import MapKit

class MapViewController: UIViewController {
    private let mapView = MKMapView()
    private let nearestBtn = UIButton(type:.system)
    private let backBtn    = UIButton(type:.system)

    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = UIColor(hex: "#D5ECD4")
      [mapView, nearestBtn, backBtn].forEach {
        view.addSubview($0)
        $0.translatesAutoresizingMaskIntoConstraints = false
      }

      mapView.layer.cornerRadius = 12

      nearestBtn.setTitle("Nearest Department", for:.normal)
      nearestBtn.backgroundColor = UIColor(hex: "#C3DAC3")
      nearestBtn.setTitleColor(.white, for:.normal)
      nearestBtn.layer.cornerRadius = 12

      backBtn.setTitle("Back", for:.normal)
      backBtn.backgroundColor = UIColor(hex: "#C3DAC3")
      backBtn.setTitleColor(.white, for:.normal)
      backBtn.layer.cornerRadius = 12

      nearestBtn.addTarget(self, action: #selector(findNearest), for: .touchUpInside)
      backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)

      NSLayoutConstraint.activate([
        mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

        nearestBtn.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
        nearestBtn.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
        nearestBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
        nearestBtn.heightAnchor.constraint(equalToConstant: 50),

        backBtn.topAnchor.constraint(equalTo: nearestBtn.bottomAnchor, constant: 16),
        backBtn.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
        backBtn.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
        backBtn.heightAnchor.constraint(equalToConstant: 50),
      ])
    }

    @objc private func findNearest() {
      // ваша логика
    }

    @objc private func goBack() {
      dismiss(animated: true)
    }
}
