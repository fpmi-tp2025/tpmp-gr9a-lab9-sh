//
//  ViewControllerMap.swift
//  BankApp
//
//  Created by Ivan Hontarau on 25.05.25.
//
import MapKit

class ViewControllerMap: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!

    let locationManager = CLLocationManager()
    var userLocation: CLLocation?
    var departments: [(name: String, coordinate: CLLocationCoordinate2D, address: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapView.backgroundColor = .lightGray
        mapView.delegate = self // Set the map view delegate

        addDepartments()
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func showRoute(_ sender: Any) {
        showRoute()
    }

    func addDepartments() {
        departments = [
            (name: "Department 1", coordinate: CLLocationCoordinate2D(latitude: 53.9022, longitude: 27.5618), address: "Address 1"),
            (name: "Department 2", coordinate: CLLocationCoordinate2D(latitude: 53.8922, longitude: 27.5618), address: "Address 2"),
            (name: "Department 3", coordinate: CLLocationCoordinate2D(latitude: 53.9122, longitude: 27.5618), address: "Address 3"),
            (name: "Department 4", coordinate: CLLocationCoordinate2D(latitude: 53.9222, longitude: 27.5618), address: "Address 4"),
            (name: "Department 5", coordinate: CLLocationCoordinate2D(latitude: 53.9322, longitude: 27.5618), address: "Address 5")
        ]

        for department in departments {
            let annotation = MKPointAnnotation()
            annotation.coordinate = department.coordinate
            annotation.title = department.name
            mapView.addAnnotation(annotation)
        }
    }

    @objc func showRoute() {
        // Check if user location is available
        guard let userLocation = userLocation else {
            let alert = UIAlertController(title: "Location Not Available", message: "Please enable location services and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        // Find the nearest department
        var nearestDepartment: (name: String, coordinate: CLLocationCoordinate2D, address: String)?
        var minDistance = Double.greatestFiniteMagnitude

        for department in departments {
            let distance = userLocation.distance(from: CLLocation(latitude: department.coordinate.latitude, longitude: department.coordinate.longitude))
            if distance < minDistance {
                minDistance = distance
                nearestDepartment = department
            }
        }

        // Ensure a nearest department was found
        guard let nearest = nearestDepartment else {
            let alert = UIAlertController(title: "No Departments Found", message: "No departments available to show the route.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }

        // Update the address label
        addressLabel.text = nearest.address

        // Request directions
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: nearest.coordinate))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let self = self else { return }

            if let error = error {
                print("Error calculating directions: \(error.localizedDescription)")
                let alert = UIAlertController(title: "Error", message: "Failed to calculate directions: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            guard let route = response?.routes.first else {
                print("No route found in response")
                let alert = UIAlertController(title: "No Route Found", message: "No route found to the destination.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }

            print("Route found, drawing on map")

            // Draw the route on the map
            self.mapView.addOverlay(route.polyline, level: .aboveLabels)

            let rect = route.polyline.boundingMapRect
            print("Bounding Map Rect: \(rect)")
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)

            self.showRouteOnMap(pickupCoordinate: userLocation.coordinate, destinationCoordinate: nearest.coordinate)
        }
    }

    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil)

        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

        let sourceAnnotation = MKPointAnnotation()
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }

        let destinationAnnotation = MKPointAnnotation()
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }

        mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)

        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile

        // Calculate the direction
        let directions = MKDirections(request: directionRequest)

        directions.calculate { (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }

            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)

            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
}

extension ViewControllerMap: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        locationManager.stopUpdatingLocation()

        // Center the map on the user's location
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)

        // Add an annotation for the user's location
        let userAnnotation = MKPointAnnotation()
        userAnnotation.coordinate = location.coordinate
        userAnnotation.title = "My Location"
        mapView.addAnnotation(userAnnotation)
    }
}

extension ViewControllerMap: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
