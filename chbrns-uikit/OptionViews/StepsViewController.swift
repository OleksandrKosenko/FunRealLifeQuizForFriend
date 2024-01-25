//
//  StepsViewController.swift
//  chbrns-uikit
//
//  Created by Alex Kosenko on 01.05.2023.
//

import UIKit
import CoreLocation
import CoreMotion

class StepsViewController: FirstDocument, CLLocationManagerDelegate {
    
    // Views
    @IBOutlet weak var compassImageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    
    
    let motionManager = CMMotionManager()
    let locationManager = CLLocationManager()
    var currentHeading: CLLocationDirection = 0
    
    var headingOffset: CLLocationDirection = 0

    
    
    private let activityManager = CMMotionActivityManager()
    private let pedometer = CMPedometer()
    private var shouldStartUpdating: Bool = false
    private var startDate: Date? = nil
    private let notAvailableStepsCounter = "Недоступно"
    
    
    var isCounting: Bool = false
    
    var stepCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.layer.cornerRadius = 13
        resetButton.clipsToBounds = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.headingFilter = kCLHeadingFilterNone

        
        // Set up motion manager
        motionManager.showsDeviceMovementDisplay = true
        motionManager.startDeviceMotionUpdates()
        
        
        
        
        checkPedometerAvailability()
        startCountingSteps()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            startUpdatingHeading()
            calibrateCompass()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        updateCompass(heading: newHeading.trueHeading)
    }
    
    func startUpdatingHeading() {
        if CLLocationManager.headingAvailable() {
            locationManager.startUpdatingHeading()
        } else {
            print("Heading data is not available.")
        }
    }
    
    func calibrateCompass() {
        let systemCompassHeading: CLLocationDirection = 0 // Replace this with the actual value from the system compass
        let currentCompassHeading = headingOffset + (locationManager.heading?.trueHeading ?? 0)
        headingOffset = systemCompassHeading - currentCompassHeading
    }



    
    func updateCompass(heading: CLLocationDirection) {
        let correctedHeading = heading + headingOffset
        let radians = -correctedHeading * Double.pi / 180.0
        let rotationTransform = CGAffineTransform(rotationAngle: CGFloat(radians))
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            self.compassImageView.transform = rotationTransform
        }
        
        headingLabel.text = String(format: "%.0f°", correctedHeading)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        motionManager.startDeviceMotionUpdates()
        guard let startDate = startDate else { return }
        updateStepsCountLabelUsing(startDate: startDate)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingHeading()
        motionManager.stopDeviceMotionUpdates()
    }
    
    func startDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (motion, error) in
                if let motion = motion {
                    self.processDeviceMotion(motion)
                }
            }
        } else {
            print("Device motion is not available.")
        }
    }

    func stopDeviceMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.stopDeviceMotionUpdates()
        }
    }
    
    func processDeviceMotion(_ motion: CMDeviceMotion) {
        let gravity = motion.gravity
        let magneticField = motion.magneticField.field
        let inclination = atan2(gravity.z, sqrt(gravity.x * gravity.x + gravity.y * gravity.y))
        let rotationMatrix = motion.attitude.rotationMatrix

        var heading = -1.0
        if magneticField.x != 0.0 || magneticField.y != 0.0 {
            heading = atan2(magneticField.y * rotationMatrix.m33 - magneticField.z * rotationMatrix.m32, magneticField.x * rotationMatrix.m33 + magneticField.y * rotationMatrix.m31) - inclination
        }
        if heading < 0.0 {
            heading += 2 * Double.pi
        }

        updateCompass(heading: heading * 180.0 / Double.pi)
    }
    
    
    func checkPedometerAvailability() {
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsCountLabel.text = notAvailableStepsCounter
        }
    }
    
    
    func stopCountingSteps() {
        pedometer.stopUpdates()
    }
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        onStop()
        stepsCountLabel.text = "0"
        onStart()
        
        
        //        shouldStartUpdating = !shouldStartUpdating
        //        shouldStartUpdating ? (onStart()) : (onStop())
    }
    
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        stopCountingSteps()
        stepsCountLabel.text = "0"
        startCountingSteps()
    }
    
}

extension StepsViewController {
    private func onStart() {
        //startButton.setTitle("Stop", for: .normal)
        startDate = Date()
        checkAuthorizationStatus()
        startUpdating()
    }
    
    private func onStop() {
        //startButton.setTitle("Start", for: .normal)
        startDate = nil
        stopUpdating()
    }
    
    private func startUpdating() {
        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsCountLabel.text = notAvailableStepsCounter
        }
    }
    
    private func checkAuthorizationStatus() {
        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            onStop()
            stepsCountLabel.text = notAvailableStepsCounter
        default:break
        }
    }
    
    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }
    
    private func on(error: Error) {
        //handle error
    }
    
    private func updateStepsCountLabelUsing(startDate: Date) {
        pedometer.queryPedometerData(from: startDate, to: Date()) {
            [weak self] pedometerData, error in
            if let error = error {
                self?.on(error: error)
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    self?.stepsCountLabel.text = String(describing: pedometerData.numberOfSteps)
                }
            }
        }
    }
    
    
    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.stepsCountLabel.text = pedometerData.numberOfSteps.stringValue
            }
        }
    }
}
