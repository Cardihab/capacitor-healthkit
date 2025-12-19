import Foundation
import Capacitor
import HealthKit

var healthStore = HKHealthStore()

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorHealthkitPlugin)
public class CapacitorHealthkitPlugin: CAPPlugin {

    enum HKSampleError: Error {
        case sleepRequestFailed
        case workoutRequestFailed
        case quantityRequestFailed
        case sampleTypeFailed
        case deniedDataAccessFailed

        var outputMessage: String {
            switch self {
            case .sleepRequestFailed:
                return "sleepRequestFailed"
            case .workoutRequestFailed:
                return "workoutRequestFailed"
            case .quantityRequestFailed:
                return "quantityRequestFailed"
            case .sampleTypeFailed:
                return "sampleTypeFailed"
            case .deniedDataAccessFailed:
                return "deniedDataAccessFailed"
            }
        }
    }

    public override func load() {
        shouldStringifyDatesInCalls = false
    }

    func getSampleType(sampleName: String) -> HKSampleType? {
        switch sampleName {
        case "stepCount":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        case "flightsClimbed":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)!
        case "appleExerciseTime":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!
        case "activeEnergyBurned":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!
        case "basalEnergyBurned":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)!
        case "distanceWalkingRunning":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!
        case "distanceCycling":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!
        case "bloodGlucose":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!
        case "sleepAnalysis":
            return HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!
        case "workoutType":
            return HKWorkoutType.workoutType()
        case "weight":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
        case "heartRate":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
        case "restingHeartRate":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!
        case "respiratoryRate":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!
        case "bodyFat":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!
        case "oxygenSaturation":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!
        case "basalBodyTemperature":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalBodyTemperature)!
        case "bodyTemperature":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!
        case "bloodPressureSystolic":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!
        case "bloodPressureDiastolic":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!
        case "vo2Max":
            return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.vo2Max)!;
        case "sixMinuteWalkTestDistance":
            if #available(iOS 14.0, *) {
                return HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.sixMinuteWalkTestDistance)!;
            }
            return nil
        case "mindfulness":
            return HKObjectType.categoryType(forIdentifier: .mindfulSession)!;
        case "standTime":
            if #available(iOS 13.0, *) {
                return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!;
            }
            return nil
        default:
            return nil
        }
    }

    func getTypes(items: [String]) -> Set<HKSampleType> {
        var types: Set<HKSampleType> = []
        for item in items {
            switch item {
            case "steps":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!)
            case "stairs":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)!)
            case "duration":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)!)
            case "activity":
                types.insert(HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!)
                types.insert(HKWorkoutType.workoutType())
            case "activeEnergyBurned":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!)
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)!)
            case "distance":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!)
            case "bloodGlucose":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!)
            case "weight":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!)
            case "heartRate":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!)
            case "restingHeartRate":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)!)
            case "respiratoryRate":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.respiratoryRate)!)
            case "bodyFat":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyFatPercentage)!)
            case "oxygenSaturation":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!)
            case "basalBodyTemperature":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalBodyTemperature)!)
            case "bodyTemperature":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!)
            case "bloodPressureSystolic":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!)
            case "bloodPressureDiastolic":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!)
            case "vo2Max":
                types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.vo2Max)!);
            case "sixMinuteWalkTestDistance":
                if #available(iOS 14.0, *) {
                    types.insert(HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.sixMinuteWalkTestDistance)!);
                } else {
                    print("no match in case: " + item)
                }
            case "mindfulness":
                types.insert(HKObjectType.categoryType(forIdentifier: .mindfulSession)!);
            case "standTime":
                if #available(iOS 13.0, *) {
                    types.insert(HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!);
                } else {
                    print("no match in case: " + item)
                }
            default:
                print("no match in case: " + item)
            }
        }
        return types
    }
    
    func returnWorkoutActivityTypeValueDictionnary(activityType: HKWorkoutActivityType) -> String {
        // from https://github.com/georgegreenoflondon/HKWorkoutActivityType-Descriptions/blob/master/HKWorkoutActivityType%2BDescriptions.swift
        switch activityType {
        case HKWorkoutActivityType.americanFootball:
            return "American Football"
        case HKWorkoutActivityType.archery:
            return "Archery"
        case HKWorkoutActivityType.australianFootball:
            return "Australian Football"
        case HKWorkoutActivityType.badminton:
            return "Badminton"
        case HKWorkoutActivityType.baseball:
            return "Baseball"
        case HKWorkoutActivityType.basketball:
            return "Basketball"
        case HKWorkoutActivityType.bowling:
            return "Bowling"
        case HKWorkoutActivityType.boxing:
            return "Boxing"
        case HKWorkoutActivityType.climbing:
            return "Climbing"
        case HKWorkoutActivityType.crossTraining:
            return "Cross Training"
        case HKWorkoutActivityType.curling:
            return "Curling"
        case HKWorkoutActivityType.cycling:
            return "Cycling"
        case HKWorkoutActivityType.dance:
            return "Dance"
        case HKWorkoutActivityType.danceInspiredTraining:
            return "Dance Inspired Training"
        case HKWorkoutActivityType.elliptical:
            return "Elliptical"
        case HKWorkoutActivityType.equestrianSports:
            return "Equestrian Sports"
        case HKWorkoutActivityType.fencing:
            return "Fencing"
        case HKWorkoutActivityType.fishing:
            return "Fishing"
        case HKWorkoutActivityType.functionalStrengthTraining:
            return "Functional Strength Training"
        case HKWorkoutActivityType.golf:
            return "Golf"
        case HKWorkoutActivityType.gymnastics:
            return "Gymnastics"
        case HKWorkoutActivityType.handball:
            return "Handball"
        case HKWorkoutActivityType.hiking:
            return "Hiking"
        case HKWorkoutActivityType.hockey:
            return "Hockey"
        case HKWorkoutActivityType.hunting:
            return "Hunting"
        case HKWorkoutActivityType.lacrosse:
            return "Lacrosse"
        case HKWorkoutActivityType.martialArts:
            return "Martial Arts"
        case HKWorkoutActivityType.mindAndBody:
            return "Mind and Body"
        case HKWorkoutActivityType.mixedMetabolicCardioTraining:
            return "Mixed Metabolic Cardio Training"
        case HKWorkoutActivityType.paddleSports:
            return "Paddle Sports"
        case HKWorkoutActivityType.play:
            return "Play"
        case HKWorkoutActivityType.preparationAndRecovery:
            return "Preparation and Recovery"
        case HKWorkoutActivityType.racquetball:
            return "Racquetball"
        case HKWorkoutActivityType.rowing:
            return "Rowing"
        case HKWorkoutActivityType.rugby:
            return "Rugby"
        case HKWorkoutActivityType.running:
            return "Running"
        case HKWorkoutActivityType.sailing:
            return "Sailing"
        case HKWorkoutActivityType.skatingSports:
            return "Skating Sports"
        case HKWorkoutActivityType.snowSports:
            return "Snow Sports"
        case HKWorkoutActivityType.soccer:
            return "Soccer"
        case HKWorkoutActivityType.softball:
            return "Softball"
        case HKWorkoutActivityType.squash:
            return "Squash"
        case HKWorkoutActivityType.stairClimbing:
            return "Stair Climbing"
        case HKWorkoutActivityType.surfingSports:
            return "Surfing Sports"
        case HKWorkoutActivityType.swimming:
            return "Swimming"
        case HKWorkoutActivityType.tableTennis:
            return "Table Tennis"
        case HKWorkoutActivityType.tennis:
            return "Tennis"
        case HKWorkoutActivityType.trackAndField:
            return "Track and Field"
        case HKWorkoutActivityType.traditionalStrengthTraining:
            return "Traditional Strength Training"
        case HKWorkoutActivityType.volleyball:
            return "Volleyball"
        case HKWorkoutActivityType.walking:
            return "Walking"
        case HKWorkoutActivityType.waterFitness:
            return "Water Fitness"
        case HKWorkoutActivityType.waterPolo:
            return "Water Polo"
        case HKWorkoutActivityType.waterSports:
            return "Water Sports"
        case HKWorkoutActivityType.wrestling:
            return "Wrestling"
        case HKWorkoutActivityType.yoga:
            return "Yoga"
        // iOS 10
        case HKWorkoutActivityType.barre:
            return "Barre"
        case HKWorkoutActivityType.coreTraining:
            return "Core Training"
        case HKWorkoutActivityType.crossCountrySkiing:
            return "Cross Country Skiing"
        case HKWorkoutActivityType.downhillSkiing:
            return "Downhill Skiing"
        case HKWorkoutActivityType.flexibility:
            return "Flexibility"
        case HKWorkoutActivityType.highIntensityIntervalTraining:
            return "High Intensity Interval Training"
        case HKWorkoutActivityType.jumpRope:
            return "Jump Rope"
        case HKWorkoutActivityType.kickboxing:
            return "Kickboxing"
        case HKWorkoutActivityType.pilates:
            return "Pilates"
        case HKWorkoutActivityType.snowboarding:
            return "Snowboarding"
        case HKWorkoutActivityType.stairs:
            return "Stairs"
        case HKWorkoutActivityType.stepTraining:
            return "Step Training"
        case HKWorkoutActivityType.wheelchairWalkPace:
            return "Wheelchair Walk Pace"
        case HKWorkoutActivityType.wheelchairRunPace:
            return "Wheelchair Run Pace"
        // iOS 11
        case HKWorkoutActivityType.taiChi:
            return "Tai Chi"
        case HKWorkoutActivityType.mixedCardio:
            return "Mixed Cardio"
        case HKWorkoutActivityType.handCycling:
            return "Hand Cycling"
        // iOS 13
        case HKWorkoutActivityType.discSports:
            return "Disc Sports"
        case HKWorkoutActivityType.fitnessGaming:
            return "Fitness Gaming"
        // iOS 14
        case HKWorkoutActivityType.cardioDance:
            return "Cardio Dance"
        case HKWorkoutActivityType.socialDance:
            return "Social Dance"
        case HKWorkoutActivityType.pickleball:
            return "Pickleball"
        // Catch-all
        default:
            return "Other"
        }
    }

    @objc func isEditionAuthorized(_ call: CAPPluginCall) {
        guard let sampleName = call.options["sampleName"] as? String else {
            return call.reject("Must provide sampleName")
        }

        let sampleType: HKSampleType? = getSampleType(sampleName: sampleName)
        if sampleType == nil {
            return call.reject("Cannot match sample name")
        }

        if healthStore.authorizationStatus(for: sampleType!) == .sharingAuthorized {
            return call.resolve()
        } else {
            return call.reject("Permission Denied to Access data")
        }
    }

    @objc func multipleIsEditionAuthorized(_ call: CAPPluginCall) {
        guard let sampleNames = call.options["sampleNames"] as? [String] else {
            return call.reject("Must provide sampleNames")
        }

        for sampleName in sampleNames {
            guard let sampleType: HKSampleType = getSampleType(sampleName: sampleName) else {
                return call.reject("Cannot match sample name")
            }
            if healthStore.authorizationStatus(for: sampleType) != .sharingAuthorized {
                return call.reject("Permission Denied to Access data")
            }
        }
        return call.resolve()
    }

    @objc func requestAuthorization(_ call: CAPPluginCall) {
        if !HKHealthStore.isHealthDataAvailable() {
            return call.reject("Health data not available")
        }
        guard let _all = call.options["all"] as? [String] else {
            return call.reject("Must provide all")
        }
        guard let _read = call.options["read"] as? [String] else {
            return call.reject("Must provide read")
        }
        guard let _write = call.options["write"] as? [String] else {
            return call.reject("Must provide write")
        }

        let writeTypes: Set<HKSampleType> = getTypes(items: _write).union(getTypes(items: _all))
        let readTypes: Set<HKSampleType> = getTypes(items: _read).union(getTypes(items: _all))

        healthStore.requestAuthorization(toShare: writeTypes, read: readTypes) { success, _ in
            if !success {
                call.reject("Could not get permission")
                return
            }
            call.resolve()
        }
    }

    @objc func queryHKitSampleTypeAnchored(_ call: CAPPluginCall) {
        guard let _sampleName = call.options["sampleName"] as? String else {
            return call.reject("Must provide sampleName")
        }
        guard let startDateString = call.options["startDate"] as? String else {
            return call.reject("Must provide startDate")
        }
        guard let endDateString = call.options["endDate"] as? String else {
            return call.reject("Must provide endDate")
        }
        
        let _startDate = getDateFromString(inputDate: startDateString)
        let _endDate = getDateFromString(inputDate: endDateString)
        
        // Get anchor if provided (base64 encoded)
        var anchor: HKQueryAnchor? = nil
        if let anchorData = call.options["anchor"] as? String,
        let decodedData = Data(base64Encoded: anchorData) {
            anchor = try? NSKeyedUnarchiver.unarchivedObject(ofClass: HKQueryAnchor.self, from: decodedData)
        }
        
        guard let sampleType: HKSampleType = getSampleType(sampleName: _sampleName) else {
            return call.reject("Error in sample name")
        }
        
        let predicate = HKQuery.predicateForSamples(withStart: _startDate, end: _endDate, options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(
            type: sampleType,
            predicate: predicate,
            anchor: anchor,
            limit: HKObjectQueryNoLimit
        ) { query, newSamples, deletedSamples, newAnchor, error in
            
            if let error = error {
                return call.reject("Query failed: \(error.localizedDescription)")
            }
            
            guard let output: [[String: Any]] = self.generateOutput(sampleName: _sampleName, results: newSamples) else {
                return call.reject("Error happened while generating outputs")
            }
            
            // Serialize the new anchor
            var anchorString: String? = nil
            if let newAnchor = newAnchor {
                if let anchorData = try? NSKeyedArchiver.archivedData(withRootObject: newAnchor, requiringSecureCoding: true) {
                    anchorString = anchorData.base64EncodedString()
                }
            }
            
            // Get deleted sample UUIDs
            let deletedUUIDs = deletedSamples?.map { $0.uuid.uuidString } ?? []
            
            call.resolve([
                "countReturn": output.count,
                "resultData": output,
                "anchor": anchorString as Any,
                "deletedUUIDs": deletedUUIDs
            ])
        }
        
        healthStore.execute(query)
    }

    @objc func queryAggregatedDailySampleType(_ call: CAPPluginCall) {
        let calendar = Calendar.current

        let interval = DateComponents(day: 1)

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.hour = 0

        guard let _sampleName = call.options["sampleName"] as? String else {
            call.reject("Must provide sampleName")
            return
        }
        guard let _startDate = call.options["startDate"] as? String else {
            call.reject("Must provide startDate")
            return
        }
        guard let _endDate = call.options["endDate"] as? String else {
            call.reject("Must provide endDate")
            return
        }

        guard let _limit = call.options["limit"] as? Int else {
            call.reject("Must provide limit")
            return
        }
        
        let limit: Int = (_limit == 0) ? HKObjectQueryNoLimit : _limit

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        guard let startDate = dateFormatter.date(from: _startDate) else {
            call.reject("Invalid startDate format")
            return
        }

        let endDate = getDateFromString(inputDate: _endDate)

        guard let anchorDate = calendar.date(from: anchorComponents) else {
            call.reject("Unable to create anchor date")
            return
        }

        guard let quantityType = getSampleType(sampleName: _sampleName) as? HKQuantityType else {
            call.reject("Unable to create aggregate for type \(_sampleName)")
            return
        }

        let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                        quantitySamplePredicate: nil,
                                        options: .cumulativeSum,
                                        anchorDate: anchorDate,
                                        intervalComponents: interval)

        query.initialResultsHandler = {
            query, results, error in

            guard let statsCollection = results else {
                call.reject("Unable to create aggregate for type \(_sampleName)")
                return
            }

            var output: [[String: Any]] = []

            let localDateFormatter = DateFormatter()
            localDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            localDateFormatter.timeZone = TimeZone.current
            
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in

                if let quantity = statistics.sumQuantity() {
                    var _unit: HKUnit = HKUnit.count()
                    if statistics.quantityType.is(compatibleWith: HKUnit.minute()) {
                        _unit = HKUnit.minute()
                    } else if statistics.quantityType.is(compatibleWith: HKUnit.kilocalorie()) {
                        _unit = HKUnit.kilocalorie()
                    }
                    
                    let value = quantity.doubleValue(for: _unit)
                    let localDateString = localDateFormatter.string(from: statistics.startDate)

                    output.append([
                        "value": value,
                        "startDate": localDateString,
                        "date": localDateString
                    ])
                }
            }
            call.resolve([
                "resultData": output
            ])
        }

        healthStore.execute(query)
    }

    @objc func queryAggregatedDailySampleTypeAnchored(_ call: CAPPluginCall) {
        let calendar = Calendar.current

        let interval = DateComponents(day: 1)

        var anchorComponents = calendar.dateComponents([.day, .month, .year], from: Date())
        anchorComponents.hour = 0

        guard let _sampleName = call.options["sampleName"] as? String else {
            call.reject("Must provide sampleName")
            return
        }
        guard let _startDate = call.options["startDate"] as? String else {
            call.reject("Must provide startDate")
            return
        }
        guard let endDateString = call.options["endDate"] as? String else {
            call.reject("Must provide endDate")
            return
        }
        
        let _endDate = getDateFromString(inputDate: endDateString)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"

        guard let startDate = dateFormatter.date(from: _startDate) else {
            call.reject("Invalid startDate format, expected yyyy/MM/dd")
            return
        }

        guard let anchorDate = calendar.date(from: anchorComponents) else {
            call.reject("Unable to create anchor date")
            return
        }

        guard let quantityType = getSampleType(sampleName: _sampleName) as? HKQuantityType else {
            call.reject("Unable to create aggregate for type \(_sampleName)")
            return
        }

        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: _endDate, options: .strictStartDate)

        let query = HKStatisticsCollectionQuery(
            quantityType: quantityType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: anchorDate,
            intervalComponents: interval
        )

        query.initialResultsHandler = { query, results, error in
            
            guard let statsCollection = results else {
                call.reject("Unable to create aggregate for type \(_sampleName)")
                return
            }

            var output: [[String: Any]] = []

            let localDateFormatter = DateFormatter()
            localDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            localDateFormatter.timeZone = TimeZone.current  // Use device timezone

            statsCollection.enumerateStatistics(from: startDate, to: _endDate) { statistics, stop in

                if let quantity = statistics.sumQuantity() {
                    var _unit: HKUnit = HKUnit.count()
                    if statistics.quantityType.is(compatibleWith: HKUnit.minute()) {
                        _unit = HKUnit.minute()
                    } else if statistics.quantityType.is(compatibleWith: HKUnit.kilocalorie()) {
                        _unit = HKUnit.kilocalorie()
                    }
                    
                    let value = quantity.doubleValue(for: _unit)

                    // Use the local date representation
                    let localDateString = localDateFormatter.string(from: statistics.startDate)
                    output.append([
                        "value": value,
                        "startDate": localDateString,
                        "date": localDateString
                    ])
                }
            }

            let anchorTimestamp = String(Date().timeIntervalSince1970)

            call.resolve([
                "resultData": output,
                "anchor": anchorTimestamp
            ])
        }

        healthStore.execute(query)
    }

    func getTimeZoneString(sample: HKSample? = nil, shouldReturnDefaultTimeZoneInExceptions _: Bool = true) -> String {
        var timeZone: TimeZone?
        if let metaDataTimeZoneValue = sample?.metadata?[HKMetadataKeyTimeZone] as? String {
            timeZone = TimeZone(identifier: metaDataTimeZoneValue)
        }
        if timeZone == nil {
            timeZone = TimeZone.current
        }
        let seconds: Int = timeZone?.secondsFromGMT() ?? 0
        let hours = seconds / 3600
        let minutes = abs(seconds / 60) % 60
        let timeZoneString = String(format: "%+.2d:%.2d", hours, minutes)
        return timeZoneString
    }

    func generateOutput(sampleName: String, results: [HKSample]?) -> [[String: Any]]? {
        var output: [[String: Any]] = []
        var device: [String: String?] = [:];
        if results == nil {
            return nil
        }
        for result in results! {
             if (result.device != nil) {
                device = [
                    "deviceIdentifier": result.device?.udiDeviceIdentifier,
                    "deviceName": result.device?.name,
                    "manufacturer": result.device?.manufacturer,
                    "model": result.device?.model,
                    "version": result.device?.firmwareVersion
                ];
            }
            if sampleName == "sleepAnalysis" {
                guard let sample = result as? HKCategorySample else {
                    return nil
                }
                let sleepSD = sample.startDate as NSDate
                let sleepED = sample.endDate as NSDate
                let sleepInterval = sleepED.timeIntervalSince(sleepSD as Date)
                let sleepHoursBetweenDates = sleepInterval / 3600
                let sleepState = (sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue) ? "InBed" : "Asleep"
                let constructedSample: [String: Any] = [
                    "uuid": sample.uuid.uuidString,
                    "timeZone": getTimeZoneString(sample: sample) as String,
                    "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                    "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                    "duration": sleepHoursBetweenDates,
                    "sleepState": sleepState,
                    "source": sample.sourceRevision.source.name,
                    "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                    "device": getDeviceInformation(device: sample.device),
                    "udiDevice": device,
                ]
                output.append(constructedSample)
            } else if sampleName == "workoutType" {
                guard let sample = result as? HKWorkout else {
                    return nil
                }

                var TEBData: Double? = -1
                var TDData: Double? = -1
                var TFCData: Double? = -1
                var TSSCData: Double? = -1

                var unitTEB: HKUnit?
                if (sample.totalEnergyBurned) != nil {
                    if (sample.totalEnergyBurned?.is(compatibleWith: HKUnit.kilocalorie()))! {
                        unitTEB = HKUnit.kilocalorie()
                    }
                    guard unitTEB != nil else { return nil }
                    TEBData = sample.totalEnergyBurned?.doubleValue(for: unitTEB!)
                }

                var unitTD: HKUnit?
                if (sample.totalDistance) != nil {
                    if (sample.totalDistance?.is(compatibleWith: HKUnit.meter()))! {
                        unitTD = HKUnit.meter()
                    }
                    guard unitTD != nil else { return nil }
                    TDData = sample.totalDistance?.doubleValue(for: unitTD!)
                }

                var unitTFC: HKUnit?
                if (sample.totalFlightsClimbed) != nil {
                    if (sample.totalFlightsClimbed?.is(compatibleWith: HKUnit.count()))! {
                        unitTFC = HKUnit.count()
                    }
                    guard unitTFC != nil else { return nil }
                    TFCData = sample.totalFlightsClimbed?.doubleValue(for: unitTFC!)
                }

                var unitTSSC: HKUnit?
                if (sample.totalSwimmingStrokeCount) != nil {
                    if (sample.totalSwimmingStrokeCount?.is(compatibleWith: HKUnit.count()))! {
                        unitTSSC = HKUnit.count()
                    }
                    guard unitTSSC != nil else { return nil }
                    TSSCData = sample.totalSwimmingStrokeCount?.doubleValue(for: unitTSSC!)
                }

                let workoutSD = sample.startDate as NSDate
                let workoutED = sample.endDate as NSDate
                let workoutInterval = workoutED.timeIntervalSince(workoutSD as Date)
                let workoutHoursBetweenDates = workoutInterval / 3600

                output.append([
                    "uuid": sample.uuid.uuidString,
                    "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                    "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                    "duration": workoutHoursBetweenDates,
                    "source": sample.sourceRevision.source.name,
                    "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                    "device": getDeviceInformation(device: sample.device),
                    "workoutActivityId": sample.workoutActivityType.rawValue,
                    "workoutActivityName": sample.workoutActivityType.name,
                    "totalEnergyBurned": TEBData!, // kilocalorie
                    "totalDistance": TDData!, // meter
                    "totalFlightsClimbed": TFCData!, // count
                    "totalSwimmingStrokeCount": TSSCData!, // count
                    "udiDevice": device,
                ])
            } else if sampleName == "bloodPressure" {
                let unitName: String = "mmHg";
                guard let sample = result as? HKCorrelation else {
                    return nil
                }
                if let systolic = sample.objects(for: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!).first as? HKQuantitySample,
                  let diastolic = sample.objects(for: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!).first as? HKQuantitySample {

                    let systolicValue = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
                    let diastolicValue = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())

                    output.append([
                        "uuid": sample.uuid.uuidString,
                        "value": [
                            "systolic": systolicValue,
                            "diastolic": diastolicValue
                        ],
                        "unitName": unitName,
                        "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                        "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                        "source": sample.sourceRevision.source.name,
                        "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                        "device": device,
                    ])
                }
            } else if sampleName == "mindfulness" {
                let mindfulnessSD = result.startDate as NSDate
                let mindfulnessED = result.endDate as NSDate
                let mindfulnessInterval = mindfulnessED.timeIntervalSince(mindfulnessSD as Date)
                let mindfulnessMinutes = mindfulnessInterval / 60;

                output.append([
                    "uuid": result.uuid.uuidString,
                    "startDate": ISO8601DateFormatter().string(from: result.startDate),
                    "endDate": ISO8601DateFormatter().string(from: result.endDate),
                    "value": mindfulnessMinutes,
                    "unitName": "minute",
                    "source": result.sourceRevision.source.name,
                    "sourceBundleId": result.sourceRevision.source.bundleIdentifier,
                    "device": device,
                ])
            } else {
                guard let sample = result as? HKQuantitySample else {
                    return nil
                }
                var unit: HKUnit?
                var unitName: String?

                if sampleName == "heartRate" {
                    unit = HKUnit(from: "count/min")
                    unitName = "BPM"
                } else if sampleName == "restingHeartRate" {
                    unit = HKUnit(from: "count/min")
                    unitName = "BPM"
                } else if sampleName == "weight" {
                    unit = HKUnit.gramUnit(with: .kilo)
                    unitName = "kilogram"
                } else if sampleName == "respiratoryRate" {
                    unit = HKUnit(from: "count/min")
                    unitName = "BrPM"
                } else if sampleName == "bodyFat" {
                    unit = HKUnit.percent()
                    unitName = "percent"
                } else if sampleName == "oxygenSaturation" {
                    unit = HKUnit.percent()
                    unitName = "percent"
                } else if sample.quantityType.is(compatibleWith: HKUnit.meter()) {
                    unit = HKUnit.meter()
                    unitName = "meter"
                } else if sample.quantityType.is(compatibleWith: HKUnit.count()) {
                    unit = HKUnit.count()
                    unitName = "count"
                } else if sample.quantityType.is(compatibleWith: HKUnit.minute()) {
                    unit = HKUnit.minute()
                    unitName = "minute"
                } else if sample.quantityType.is(compatibleWith: HKUnit.kilocalorie()) {
                    unit = HKUnit.kilocalorie()
                    unitName = "kilocalorie"
                } else if sample.quantityType.is(compatibleWith: HKUnit.gramUnit(with: .kilo)) {
                    unit = HKUnit.gramUnit(with: .kilo)
                    unitName = "kilogram"
                } else if sample.quantityType.is(compatibleWith: HKUnit.moleUnit(withMolarMass: HKUnitMolarMassBloodGlucose).unitDivided(by: HKUnit.literUnit(with: .kilo))) {
                    unit = HKUnit.moleUnit(withMolarMass: HKUnitMolarMassBloodGlucose).unitDivided(by: HKUnit.literUnit(with: .kilo))
                    unitName = "mmol/L"
                } else if sample.quantityType.is(compatibleWith: HKUnit.degreeCelsius()) {
                    unit = HKUnit.degreeCelsius()
                    unitName = "celsius"
                } else if sample.quantityType.is(compatibleWith: HKUnit.degreeFahrenheit()) {
                    unit = HKUnit.degreeFahrenheit()
                    unitName = "fahrenheit"
                } else if sample.quantityType.is(compatibleWith: HKUnit.kelvin()) {
                    unit = HKUnit.kelvin()
                    unitName = "kelvin"
                } else if sample.quantityType.is(compatibleWith: HKUnit.millimeterOfMercury()) {
                    unit = HKUnit.millimeterOfMercury()
                    unitName = "mmHg"
                } else if sample.quantityType.is(compatibleWith: HKUnit.count().unitDivided(by: HKUnit.minute())) {
                    unit = HKUnit.count().unitDivided(by: HKUnit.minute());
                    unitName = "bpm"
                } else if sample.quantityType.is(compatibleWith: HKUnit(from: "ml/(kg*min)")) {
                    unit = HKUnit(from: "ml/(kg*min)");
                    unitName = "ml/(kg*min)";
                } else {
                    print("Error: unknown unit type")
                }

                var value: Double 
                let quantitySD: NSDate
                let quantityED: NSDate
                quantitySD = sample.startDate as NSDate
                quantityED = sample.endDate as NSDate
                let quantityInterval = quantityED.timeIntervalSince(quantitySD as Date)
                let quantitySecondsInAnHour: Double = 3600
                let quantityHoursBetweenDates = quantityInterval / quantitySecondsInAnHour

                output.append([
                    "uuid": sample.uuid.uuidString,
                    "value": sample.quantity.doubleValue(for: unit!),
                    "unitName": unitName!,
                    "startDate": ISO8601DateFormatter().string(from: sample.startDate),
                    "endDate": ISO8601DateFormatter().string(from: sample.endDate),
                    "duration": quantityHoursBetweenDates,
                    "source": sample.sourceRevision.source.name,
                    "sourceBundleId": sample.sourceRevision.source.bundleIdentifier,
                    "device": getDeviceInformation(device: sample.device),
                    "udiDevice": device,
                ])
            }
        }
        return output
    }

    func getDeviceInformation(device: HKDevice?) -> [String: String?]? {
        if (device == nil) {
            return nil;
        }
        
        let deviceInformation: [String: String?] = [
            "name": device?.name,
            "model": device?.model,
            "manufacturer": device?.manufacturer,
            "hardwareVersion": device?.hardwareVersion,
            "softwareVersion": device?.softwareVersion,
        ];
                
        return deviceInformation;
    }

    func getDateFromString(inputDate: String) -> Date{
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions =  [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: inputDate)!
    }

    
    @objc func requestAuthorization(_ call: CAPPluginCall) {
        if !HKHealthStore.isHealthDataAvailable() {
            return call.reject("Health data not available")
        }
        guard let _all = call.options["all"] as? [String] else {
            return call.reject("Must provide all")
        }
        guard let _read = call.options["read"] as? [String] else {
            return call.reject("Must provide read")
        }
        guard let _write = call.options["write"] as? [String] else {
            return call.reject("Must provide write")
        }

        let writeTypes: Set<HKSampleType> = getTypes(items: _write).union(getTypes(items: _all))
        let readTypes: Set<HKSampleType> = getTypes(items: _read).union(getTypes(items: _all))

        healthStore.requestAuthorization(toShare: writeTypes, read: readTypes) { success, _ in
            if !success {
                call.reject("Could not get permission")
                return
            }
            call.resolve()
        }
    }
    @objc func queryHKitSampleType(_ call: CAPPluginCall) {
        guard let _sampleName = call.options["sampleName"] as? String else {
            return call.reject("Must provide sampleName")
        }
        guard let startDateString = call.options["startDate"] as? String else {
            return call.reject("Must provide startDate")
        }
        guard let endDateString = call.options["endDate"] as? String else {
            return call.reject("Must provide endDate")
        }

        let _startDate = getDateFromString(inputDate: startDateString)
        let _endDate = getDateFromString(inputDate: endDateString)
        guard let _limit = call.options["limit"] as? Int else {
            return call.reject("Must provide limit")
        }

        let limit: Int = (_limit == 0) ? HKObjectQueryNoLimit : _limit

        let predicate = HKQuery.predicateForSamples(withStart: _startDate, end: _endDate, options: HKQueryOptions.strictStartDate)

        guard let sampleType: HKSampleType = getSampleType(sampleName: _sampleName) else {
            return call.reject("Error in sample name")
        }

        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: nil) {
            _, results, error in
            guard let samples = results else {
                call.reject("Could not query data")
                return
            }
            guard let output: [[String: Any]] = self.generateOutput(sampleName: _sampleName, results: results) else {
                call.reject("Error happened while generating outputs")
                return
            }
            call.resolve([
                "countReturn": output.count,
                "resultData": output,
            ])
        }
        healthStore.execute(query)
    }
    
    @objc func isAvailable(_ call: CAPPluginCall) {
        if HKHealthStore.isHealthDataAvailable() {
            return call.resolve([
                "available": true
            ])
        } else {
            return call.reject("Health data not available")
        }
    }

    @objc func isEditionAuthorized(_ call: CAPPluginCall) {
        guard let sampleName = call.options["sampleName"] as? String else {
            return call.reject("Must provide sampleName")
        }

        let sampleType: HKSampleType? = getSampleType(sampleName: sampleName)
        if sampleType == nil {
            return call.reject("Cannot match sample name")
        }

        if healthStore.authorizationStatus(for: sampleType!) == .sharingAuthorized {
            return call.resolve()
        } else {
            return call.reject("Permission Denied to Access data")
        }
    }

    @objc func multipleQueryHKitSampleType(_ call: CAPPluginCall) {
        guard let _sampleNames = call.options["sampleNames"] as? [String] else {
            call.reject("Must provide sampleNames")
            return
        }
        guard let _startDate = call.options["startDate"] as? Date else {
            call.reject("Must provide startDate")
            return
        }
        guard let _endDate = call.options["endDate"] as? Date else {
            call.reject("Must provide endDate")
            return
        }
        guard let _limit = call.options["limit"] as? Int else {
            call.reject("Must provide limit")
            return
        }

        let limit: Int = (_limit == 0) ? HKObjectQueryNoLimit : _limit

        var output: [String: [String: Any]] = [:]

        let dispatchGroup = DispatchGroup()

        for _sampleName in _sampleNames {
            dispatchGroup.enter()

            queryHKitSampleTypeSpecial(sampleName: _sampleName, startDate: _startDate, endDate: _endDate, limit: limit) { result in
                switch result {
                case let .success(sampleOutput):
                    output[_sampleName] = sampleOutput
                case let .failure(error):

                    var errorMessage = ""
                    if let localError = error as? HKSampleError {
                        errorMessage = localError.outputMessage
                    } else {
                        errorMessage = error.localizedDescription
                    }
                    output[_sampleName] = ["errorDescription": errorMessage]
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            print(output.description)
            call.resolve(output)
        }
    }
      
    func queryHKitSampleTypeSpecial(sampleName: String, startDate: Date, endDate: Date, limit: Int, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: HKQueryOptions.strictStartDate)

        guard let sampleType: HKSampleType = getSampleType(sampleName: sampleName) else {
            return completion(.failure(HKSampleError.sampleTypeFailed))
        }

        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: limit, sortDescriptors: nil) {
            _, results, _ in
            guard let output: [[String: Any]] = self.generateOutput(sampleName: sampleName, results: results) else {
                return completion(.failure(HKSampleError.sampleTypeFailed))
            }
            completion(.success([
                "countReturn": output.count,
                "resultData": output,
            ]))
        }
        healthStore.execute(query)
    }
}

extension HKWorkoutActivityType {

    /*
     Simple mapping of available workout types to a human readable name.
     */
    var name: String {
        switch self {
            case .americanFootball:
                return "americanFootball"
            case .archery:
                return "archery"
            case .australianFootball:
                return "australianFootball"
            case .badminton:
                return "badminton"
            case .baseball:
                return "baseball"
            case .basketball:
                return "basketball"
            case .bowling:
                return "bowling"
            case .boxing:
                return "boxing"
            case .climbing:
                return "climbing"
            case .crossTraining:
                return "crossTraining"
            case .curling:
                return "curling"
            case .cycling:
                return "cycling"
            case .dance:
                return "dance"
            case .danceInspiredTraining:
                return "danceInspiredTraining"
            case .elliptical:
                return "elliptical"
            case .equestrianSports:
                return "equestrianSports"
            case .fencing:
                return "fencing"
            case .fishing:
                return "fishing"
            case .functionalStrengthTraining:
                return "functionalStrengthTraining"
            case .golf:
                return "golf"
            case .gymnastics:
                return "gymnastics"
            case .handball:
                return "handball"
            case .hiking:
                return "hiking"
            case .hockey:
                return "hockey"
            case .hunting:
                return "hunting"
            case .lacrosse:
                return "lacrosse"
            case .martialArts:
                return "martialArts"
            case .mindAndBody:
                return "mindAndBody"
            case .mixedMetabolicCardioTraining:
                return "mixedMetabolicCardioTraining"
            case .paddleSports:
                return "paddleSports"
            case .play:
                return "play"
            case .preparationAndRecovery:
                return "preparationAndRecovery"
            case .racquetball:
                return "racquetball"
            case .rowing:
                return "rowing"
            case .rugby:
                return "rugby"
            case .running:
                return "running"
            case .sailing:
                return "sailing"
            case .skatingSports:
                return "skatingSports"
            case .snowSports:
                return "snowSports"
            case .soccer:
                return "soccer"
            case .softball:
                return "softball"
            case .squash:
                return "squash"
            case .stairClimbing:
                return "stairClimbing"
            case .surfingSports:
                return "surfingSports"
            case .swimming:
                return "swimming"
            case .tableTennis:
                return "tableTennis"
            case .tennis:
                return "tennis"
            case .trackAndField:
                return "trackAndField"
            case .traditionalStrengthTraining:
                return "traditionalStrengthTraining"
            case .volleyball:
                return "volleyball"
            case .walking:
                return "walking"
            case .waterFitness:
                return "waterFitness"
            case .waterPolo:
                return "waterPolo"
            case .waterSports:
                return "waterSports"
            case .wrestling:
                return "wrestling"
            case .yoga:
                return "yoga"

            // iOS 10
            case .barre:
                return "barre"
            case .coreTraining:
                return "coreTraining"
            case .crossCountrySkiing:
                return "crossCountrySkiing"
            case .downhillSkiing:
                return "downhillSkiing"
            case .flexibility:
                return "flexibility"
            case .highIntensityIntervalTraining:
                return "highIntensityIntervalTraining"
            case .jumpRope:
                return "jumpRope"
            case .kickboxing:
                return "kickboxing"
            case .pilates:
                return "pilates"
            case .snowboarding:
                return "snowboarding"
            case .stairs:
                return "stairs"
            case .stepTraining:
                return "stepTraining"
            case .wheelchairWalkPace:
                return "wheelchairWalkPace"
            case .wheelchairRunPace:
                return "wheelchairRunPace"

            // iOS 11
            case .taiChi:
                return "taiChi"
            case .mixedCardio:
                return "mixedCardio"
            case .handCycling:
                return "handCycling"

            // iOS 13
            case .discSports:
                return "discSports"
            case .fitnessGaming:
                return "fitnessGaming"

            // iOS 14
            case .cardioDance:
                return "cardioDance"
            case .socialDance:
                return "socialDance"
            case .pickleball:
                return "pickleball"

            // Catch-all
            default:
                return "other"
        }
    }

}

