//
//  MapVC.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//


import UIKit
import MapKit
import SwiftyJSON

class MapVC: UIViewController, CLLocationManagerDelegate {
    
    var mapView: MapView!
    var btns = JSON(parseJSON: groupsBtn)
    var allAnnotation = JSON(parseJSON: mapPinsData)
    lazy var filteredAnnotation = allAnnotation
    let locationManager = CLLocationManager()
    
    override func loadView() {
        mapView = MapView()
        self.view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerViewOnUserLocation()
    }
    
    func setupUI() {
        setupBtns()
        mapView.selectedBtn(tag: 1)
        setupPins(data: allAnnotation)
        locationManager.delegate = self
        mapView.mkMapView.delegate = self
        checkLocationServices()
        centerViewOnUserLocation()
        
        mapView.tableView.register(PinCell.self, forCellReuseIdentifier: "cell")
        mapView.tableView.delegate = self
        mapView.tableView.dataSource = self
        mapView.tableView.showsVerticalScrollIndicator = false
        mapView.searchBar.addTarget(self, action: #selector(searchBarTextDidChange(_:)), for: .editingChanged)
    }
    
    func setupBtns() {
        for i in 0..<btns.count {
            let groupBtn: UIButton = mapView.createBtn(title: btns[i]["title"].stringValue)
            let vw = UIView()
            vw.addSubview(groupBtn)
            vw.backgroundColor = .clear
            vw.layer.cornerRadius = 22
            vw.layer.borderWidth = 2
            groupBtn.snp.makeConstraints { $0.edges.equalToSuperview().inset(7) }
            mapView.stack.addArrangedSubview(vw)
            groupBtn.tag = i + 1
            groupBtn.addTarget(self, action: #selector(groupBtnTapped(_:)), for: .touchUpInside)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            accessLocationAlert()
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            mapView.mkMapView.showsUserLocation = true
            centerViewOnUserLocation()
        case .authorizedWhenInUse:
            mapView.mkMapView.showsUserLocation = true
            centerViewOnUserLocation()
            break
        case .denied:
            accessLocationAlert()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        @unknown default:
            break
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: mapView.regionInMeters, longitudinalMeters: mapView.regionInMeters)
            mapView.mkMapView.setRegion(region, animated: true)
        }
    }
    
    func accessLocationAlert() {
        let alertController = UIAlertController(title: "Вы запретили использовать местоположение", message: "Для использоание местоположения необходимо предоставить доступ через найстройки вашего IPhone-а", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Настройки", style: .default, handler: { _ in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
            }
        }))
        present(alertController, animated: true)
    }
    
    func  setupPins(data: JSON) {
        mapView.mkMapView.removeAnnotations(mapView.mkMapView.annotations)
        for i in 0..<data.count {
            let annotation = Annotation(
                title: data[i]["name"].stringValue,
                location: CLLocationCoordinate2D(
                    latitude: data[i]["longitude"].doubleValue,
                    longitude: data[i]["latitude"].doubleValue),
                address: data[i]["address"].stringValue,
                city: data[i]["city"].stringValue,
                type: data[i]["type"].stringValue,
                img: UIImage(named: data[i]["img"].stringValue),
                workHours: data[i]["workHours"]
            )
            mapView.mkMapView.addAnnotation(annotation)
        }
    }
    
    func updateMapPins(filterText: String?, searchText: String?) {
        filteredAnnotation = []

        if let filter = filterText  {
            for i in 0..<allAnnotation.count {
                if allAnnotation[i]["type"].stringValue == filter {
                    filteredAnnotation.arrayObject?.append(allAnnotation[i])
                }
            }
            setupPins(data: filteredAnnotation)
        } else if let searchText = searchText, !searchText.isEmpty {
            for i in 0..<allAnnotation.count {
                let name = (allAnnotation[i]["name"].stringValue).lowercased()
                let address = (allAnnotation[i]["address"].stringValue).lowercased()
                let type = (allAnnotation[i]["type"].stringValue).lowercased()
                if name.contains(searchText.lowercased()) ||
                    address.contains(searchText.lowercased()) ||
                    type.contains(searchText.lowercased()) {
                    filteredAnnotation.arrayObject?.append(allAnnotation[i])
                }
            }
            setupPins(data: filteredAnnotation)
        } else {
            filteredAnnotation = allAnnotation
            setupPins(data: allAnnotation)
        }
        mapView.tableView.reloadData()
    }

    @objc func searchBarTextDidChange(_ sender: UISearchTextField) {
        updateMapPins(filterText: nil, searchText: sender.text)
    }
    
    @objc func groupBtnTapped(_ sender: UIButton) {
        mapView.selectedBtn(tag: sender.tag)
        let selectedFilter = sender.titleLabel?.text == "Все" ? nil : sender.titleLabel?.text
        updateMapPins(filterText: selectedFilter, searchText: nil)
    }

}


extension MapVC {
    
    class MapView: UIView {
        let backView = UIView()
        var mkMapView = MKMapView()
        let searchBar = UISearchTextField()
        let pinTypes = UIView()
        let scrollView: UIScrollView = UIScrollView()
        let stack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 10
            return stack
        }()
        let regionInMeters: Double = 500000
        
        var expandingView: UIView = UIView()
        var expandingViewHeight: CGFloat = 150
        var tableView: UITableView = UITableView()
        let screenHeight = UIApplication.shared.windows.first?.frame.height
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            searchBar.layer.borderColor = UIColor(named: "selected_map_group")?.cgColor
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupUI()
        }
        
        private func setupUI() {
            guard let screenHeight = screenHeight else { return }
            guard let screenWidth = UIApplication.shared.windows.first?.frame.width else { return }
            let homeIndicator = UIImageView(image: UIImage(named: "home_indicator"))
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: screenHeight - expandingViewHeight, right: 0)
            backView.backgroundColor = UIColor(named: "main_view")
            backView.layer.cornerRadius = 24
            backView.clipsToBounds = true
            backView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            scrollView.showsHorizontalScrollIndicator = false
            pinTypes.backgroundColor = UIColor(named: "segment_back")
            backgroundColor = .clear
            
            expandingView.backgroundColor = UIColor(named: "segment_back")
            tableView.backgroundColor = UIColor(named: "segment_back")
            tableView.separatorStyle = .none
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
            expandingView.addGestureRecognizer(panGesture)
            
            searchBar.borderStyle = .roundedRect
            searchBar.layer.borderColor = UIColor(named: "selected_map_group")?.cgColor
            searchBar.placeholder = "Поиск отделений / банкомата"
            searchBar.leftViewMode = .never
            searchBar.rightView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
            searchBar.rightViewMode = .always
            searchBar.rightView?.tintColor = .lightGray
            
            addSubview(backView)
            addSubview(searchBar)
            addSubview(pinTypes)
            addSubview(mkMapView)
            pinTypes.addSubview(scrollView)
            scrollView.addSubview(stack)
            
            addSubview(expandingView)
            expandingView.addSubview(tableView)
            expandingView.addSubview(homeIndicator)
            
            expandingView.frame = CGRect(x: 0, y: screenHeight - expandingViewHeight, width: screenWidth, height: screenHeight)
            
            backView.snp.makeConstraints { make in
                make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(15)
                make.leading.trailing.bottom.equalToSuperview()
            }
            searchBar.snp.makeConstraints { make in
                make.top.equalTo(backView.snp.top).inset(15)
                make.leading.trailing.equalToSuperview().inset(35)
                make.height.equalTo(45)
            }
            pinTypes.snp.makeConstraints { make in
                make.top.equalTo(searchBar.snp.bottom).offset(15)
                make.leading.trailing.bottom.equalToSuperview()
            }
            mkMapView.snp.makeConstraints { make in
                make.top.equalTo(scrollView.snp.bottom).offset(10)
                make.leading.trailing.bottom.equalToSuperview()
            }
            scrollView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(50)
            }
            stack.snp.makeConstraints { make in
                make.leading.equalToSuperview().inset(15)
                make.top.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalToSuperview()
            }
            tableView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(30)
                make.leading.trailing.bottom.equalToSuperview()
            }
            homeIndicator.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().inset(10)
            }
        }
        
        func createBtn(title: String) -> UIButton {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            button.setTitleColor(UIColor(named: "btnTitleColor"), for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.layer.cornerRadius = 17
            button.backgroundColor = UIColor(named: "map_group")
            return button
        }
        
        func selectedBtn(tag: Int) {
            guard let button = viewWithTag(tag) as? UIButton else { return }
            stack.arrangedSubviews.forEach { subview in
                if subview == button.superview {
                    subview.layer.borderColor = UIColor(named: "selected_map_group")?.cgColor
                    button.backgroundColor = UIColor(named: "selected_map_group")
                    button.isSelected = true
                } else {
                    subview.layer.borderColor = UIColor.clear.cgColor
                    let btn = subview.subviews.first as? UIButton
                    btn?.backgroundColor = UIColor(named: "map_group")
                    btn?.isSelected = false
                }
            }
        }
        
        @objc func didPan(_ gesture: UIPanGestureRecognizer) {
            let touchPoint = gesture.location(in: window)
            guard let screenHeight = screenHeight else { return }
            switch gesture.state {
            case .began:
                break
            case .changed:
                let newHeight = max(screenHeight - touchPoint.y, screenHeight)
                expandingView.frame = CGRect(x: 0, y: touchPoint.y, width: mkMapView.frame.width, height: newHeight)
            case .ended, .cancelled:
                let newHeight = touchPoint.y < (screenHeight / 2) + 100 ? mkMapView.frame.origin.y : screenHeight - expandingViewHeight
                UIView.animate(withDuration: 0.5) {
                    self.expandingView.frame = CGRect(
                        x: 0,
                        y: newHeight,
                        width: self.mkMapView.frame.width,
                        height: self.mkMapView.frame.height
                    )
                }
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: newHeight - expandingViewHeight - 100, right: 0)
            case .possible:
                break
            case .failed:
                break
            @unknown default:
                break
            }
        }
    }

}

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let cluster = view.annotation as? MKClusterAnnotation {
            mapView.deselectAnnotation(view.annotation, animated: true)
            var distance = getRegionRadius(mapView: mapView) / 10
            distance = distance > 1000 ? distance : 1000
            let location = CLLocation(latitude: cluster.coordinate.latitude, longitude: cluster.coordinate.longitude)
            centerMapOnLocation(location: location, regionRadius: distance)
        } else if !(view.annotation is MKUserLocation) {
            let mapInfoVC = MapInfoVC()
            if let annotation = view.annotation as? Annotation {
                mapInfoVC.annotation = annotation
            }
            mapInfoVC.modalPresentationStyle = .custom
            mapInfoVC.transitioningDelegate = mapInfoVC
            mapInfoVC.deselectAnnotation = { [weak self] in
                self?.mapView.mkMapView.deselectAnnotation(view.annotation, animated: true)
            }
            present(mapInfoVC, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        var marker: MKMarkerAnnotationView
        let identifier = "PinAnnotationIdentifier"
        
        if let cluster = annotation as? MKClusterAnnotation {
            cluster.title = nil
            cluster.subtitle = nil
            marker = MKMarkerAnnotationView()
            marker.glyphText = String(cluster.memberAnnotations.count)
            marker.markerTintColor = UIColor(named: "tab_bar_selected_item")
            marker.canShowCallout = false
            return marker
        }

        guard annotation is Annotation else { return nil }

        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            marker = dequeuedAnnotationView
            marker.annotation = annotation
        } else {
            marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            marker.canShowCallout = true
        }
        
        marker.clusteringIdentifier = "clusterId"
        marker.markerTintColor = UIColor(named: "tab_bar_selected_item")
        if let subtitle = annotation.subtitle, let sub = subtitle {
            if sub.contains("Центральный офис") || sub.contains("Филиал") {
                marker.glyphImage = OriginalUIImage(named: "bank")
            } else if sub.contains("ЦБО") {
                marker.glyphImage = OriginalUIImage(named: "bankomat")
            } else if sub.contains("АТМ") {
                marker.glyphImage = OriginalUIImage(named: "terminal")
            } else {
                marker.glyphImage = OriginalUIImage(named: "bank")
            }
        }
        return marker
    }
    
    func getRegionRadius(mapView: MKMapView) -> Double {
        let span = mapView.region.span
        let center = mapView.region.center
        
        let location1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
        let location2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
        let location3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
        let location4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
        
        let metersInLatitude = location1.distance(from: location2)
        let metersInLongitude = location3.distance(from: location4)
        
        return (metersInLatitude + metersInLongitude) / 2
    }
    
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance, animated: Bool = true) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        mapView.mkMapView.setRegion(coordinateRegion, animated: animated)
    }
}

extension MapVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mapInfoVC = MapInfoVC()
        
        mapInfoVC.annotation = Annotation(
            title: filteredAnnotation[indexPath.row]["name"].stringValue,
            location: CLLocationCoordinate2D(
                latitude: filteredAnnotation[indexPath.row]["longitude"].doubleValue,
                longitude: filteredAnnotation[indexPath.row]["latitude"].doubleValue),
            address: filteredAnnotation[indexPath.row]["address"].stringValue,
            city: filteredAnnotation[indexPath.row]["city"].stringValue,
            type: filteredAnnotation[indexPath.row]["type"].stringValue,
            img: UIImage(named: filteredAnnotation[indexPath.row]["img"].stringValue),
            workHours: filteredAnnotation[indexPath.row]["workHours"]
        )
        
        
        
        mapInfoVC.modalPresentationStyle = .custom
        mapInfoVC.transitioningDelegate = mapInfoVC
        present(mapInfoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension MapVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnnotation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PinCell
        let annotation = filteredAnnotation[indexPath.row]
        cell.address.text = "\(annotation["city"].stringValue) - \(annotation["address"].stringValue) (\((annotation["type"].stringValue))"
        cell.title.text = annotation["name"].stringValue
        cell.state.text = "Открыто"
        cell.ico.image = UIImage(named: annotation["img"].stringValue)
        return cell
    }
}

extension MapVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let screenHeight = UIApplication.shared.windows.first?.frame.height else { return }
        let point = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
        let expandedViewYPoint = screenHeight - mapView.expandingViewHeight
        
        if point < 0 && mapView.expandingView.frame.origin.y > mapView.mkMapView.frame.origin.y {
            scrollView.setContentOffset(.zero, animated: false)
            mapView.expandingView.frame.origin.y = expandedViewYPoint - (point * (-1))
            mapView.expandingView.frame.size.height = screenHeight
            if mapView.expandingView.frame.origin.y < mapView.mkMapView.frame.origin.y {
                mapView.expandingView.frame.origin.y = mapView.mkMapView.frame.origin.y
            }
        }
        if scrollView.contentOffset.y < 0 {
            scrollView.setContentOffset(.zero, animated:  false)
            if scrollView.panGestureRecognizer.state == .changed &&
                mapView.expandingView.frame.origin.y < screenHeight - mapView.expandingViewHeight {
                mapView.expandingView.frame.origin.y = mapView.mkMapView.frame.origin.y + point
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard let screenHeight = mapView.screenHeight else { return }
        let isOpened = mapView.expandingView.frame.origin.y < screenHeight / 2 + 100
        let isClosed = mapView.expandingView.frame.origin.y > screenHeight / 2 - 100
        
        if isOpened && mapView.expandingView.frame.origin.y > mapView.mkMapView.frame.origin.y + 120 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
                self.mapView.expandingView.frame.origin.y = screenHeight - self.mapView.expandingViewHeight
                self.mapView.expandingView.frame.size.height = self.mapView.mkMapView.frame.size.height
            }
        } else if isClosed && mapView.expandingView.frame.origin.y < screenHeight - mapView.expandingViewHeight - 120 {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
                self.mapView.expandingView.frame.origin.y = self.mapView.mkMapView.frame.origin.y
                self.mapView.expandingView.frame.size.height = self.mapView.mkMapView.frame.size.height
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut) {
                self.mapView.expandingView.frame.origin.y = isClosed ? screenHeight - self.mapView.expandingViewHeight : self.mapView.mkMapView.frame.origin.y
                self.mapView.expandingView.frame.size.height = self.mapView.mkMapView.frame.size.height
            }
        }
        mapView.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: mapView.mkMapView.frame.origin.y - mapView.expandingViewHeight - 100, right: 0)
    }
    
}
