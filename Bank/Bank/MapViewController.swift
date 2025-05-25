//
//  MapViewController.swift
//  Bank
//
//  Created by Victoria Ivanova on 25.05.25.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    private let mapView: MKMapView = {
        let mv = MKMapView()
        mv.layer.cornerRadius = 12
        mv.translatesAutoresizingMaskIntoConstraints = false
        return mv
    }()

    private let nearestButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Nearest Department", for: .normal)
        b.backgroundColor = UIColor(hex: "#C3DAC3")
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    private let backButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Back", for: .normal)
        b.backgroundColor = UIColor(hex: "#C3DAC3")
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#D5ECD4")
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(mapView)
        view.addSubview(nearestButton)
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            // карта сверху, 50% высоты, отступы 20
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            // кнопка Nearest под картой
            nearestButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20),
            nearestButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            nearestButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            nearestButton.heightAnchor.constraint(equalToConstant: 50),

            // кнопка Back под Nearest
            backButton.topAnchor.constraint(equalTo: nearestButton.bottomAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            backButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
