//
//  Persistence.swift
//  TrapScores
//
//  Created by Doxie Davis on 3/1/22.
//

import CoreData
import SwiftUI
import CloudKit
import AVFoundation
import MediaPlayer

class RoundsDataStack: ObservableObject {
    
    @Published var roundsData: [RoundEntity] = []
    
    @Published var amerOpactity = 1.0
    @Published var contOpactity = 0.5
    @Published var intlOpacity = 0.5
    @Published var selectedRange = "American"
    @Published var range = ""
    @Published var shotCount = 0
    @Published var totScore = 0
    @Published var comment = ""
    @Published var hitScore = false
    @Published var posCount = [0, 0, 0, 0, 0]
    @Published var roundTotal = 0
    @Published var posLoc = 0
    @Published var posSelected = false
    @Published var resetVolume = false
    @Published var scoringStarted = false
    @Published var viewSet = false
    @Published var clickerConfirm = false
    @Published var showInfo = false
    @Published var roundDate = Date()
    @Published var editDone = false
    @Published var roundComplete = false
    @Published var exitNewRound = false
    @Published var seePos = [0.3, 0.3, 0.3, 0.3, 0.3]
    @Published var clickerOpacity = 1.0
    @Published var phoneOpacity = 0.3
    @Published var phoneScoring = false
    
    @Published var pos1Avg = Double (0.0)
    @Published var pos2Avg = Double (0.0)
    @Published var pos3Avg = Double (0.0)
    @Published var pos4Avg = Double (0.0)
    @Published var pos5Avg = Double (0.0)
    @Published var totalAvg = Double (0.0)
    @Published var totalRnds = 0
    
    private var outputVolumeObserve: NSKeyValueObservation?
    private var audioSession = AVAudioSession.sharedInstance()
    private var priorVolume = 0.5
    private var newVolume = 0.0
    
    struct PersistenceController {
        static let shared = PersistenceController()
        
        static var preview: PersistenceController = {
            let result = PersistenceController(inMemory: true)
            let viewContext = result.container.viewContext
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Error \(nsError), \(nsError.userInfo)")
            }
            return result
        }()
        
        let container: NSPersistentContainer
        
        init(inMemory: Bool = false) {
            container = NSPersistentCloudKitContainer(name: "TrapScoresModel")
            if inMemory {
                container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            }
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
    }
    
    var managedObjectContext: NSManagedObjectContext {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"{
            return PersistenceController.preview.container.viewContext
        }
        return PersistenceController.shared.container.viewContext
    }
    
    init() {
        self.fetchRounds()
        self.calcAvgs()
    }
    
    func fetchRounds() {
        let request = NSFetchRequest<RoundEntity>(entityName: "RoundEntity")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let predicate = NSPredicate(format: "range == %@", selectedRange)
        request.predicate = predicate
        request.sortDescriptors = [sortDescriptor]
        do {
            roundsData = try managedObjectContext.fetch(request)
        } catch let error {
            print ("Error fetching. \(error)")
        }
    }
    
    func saveRounds() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
            fetchRounds()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func addRound(range: String, comment: String, date: Date, id: UUID, pos1: Int64, pos2: Int64, pos3: Int64, pos4: Int64, pos5: Int64, total: Int64 ) {
        let newRound = RoundEntity(context: managedObjectContext)
        newRound.range = range
        newRound.comment = comment
        newRound.date = date
        newRound.id = id
        newRound.pos1 = pos1
        newRound.pos2 = pos2
        newRound.pos3 = pos3
        newRound.pos4 = pos4
        newRound.pos5 = pos5
        newRound.total = total
        saveRounds()
        calcAvgs()
    }
    
    func deleteRound(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = roundsData[index]
        managedObjectContext.delete(entity)
        saveRounds()
        calcAvgs()
    }
    
    func editRound(entity: RoundEntity) {
        // set new data to edited data
        saveRounds()
        calcAvgs()
    }
    
    func countShot () {
        if hitScore == true {
            roundTotal += 1
            posCount[posLoc] += 1
        }
        shotCount += 1
        if shotCount == 25 {
            roundComplete = true
        }
        if shotCount == 5 || shotCount == 10 || shotCount == 15 ||  shotCount == 20 {
            posLoc += 1
        }
        if posLoc < 5 {
            seePos[posLoc] = 1.0
        }
        if posLoc == 5 {
            posLoc = 0
        }
        hitScore = false
    }
    
    func calcAvgs () {
        for _ in 0...roundsData.count {
            pos1Avg = Double(roundsData.reduce(0, {$0 + $1.pos1}))/Double(roundsData.count)
            pos2Avg = Double(roundsData.reduce(0, {$0 + $1.pos2}))/Double(roundsData.count)
            pos3Avg = Double(roundsData.reduce(0, {$0 + $1.pos3}))/Double(roundsData.count)
            pos4Avg = Double(roundsData.reduce(0, {$0 + $1.pos4}))/Double(roundsData.count)
            pos5Avg = Double(roundsData.reduce(0, {$0 + $1.pos5}))/Double(roundsData.count)
            totalAvg = Double(roundsData.reduce(0, {$0 + $1.total}))/Double(roundsData.count)
        }
        totalRnds = roundsData.count
        if totalRnds == 0 {
            pos1Avg = 0
            pos2Avg = 0
            pos3Avg = 0
            pos4Avg = 0
            pos5Avg = 0
            totalAvg = 0
        }
    }
    
    func clearData () {
        
        shotCount = 0
        totScore = 0
        comment = ""
        hitScore = false
        posCount = [0, 0, 0, 0, 0]
        roundTotal = 0
        posLoc = 0
        posSelected = false
        resetVolume = false
        viewSet = false
        clickerConfirm = false
        roundComplete = false
        scoringStarted = false
        showInfo = false
        seePos = [0.3, 0.3, 0.3, 0.3, 0.3]
        editDone = false
        exitNewRound = false
    }
    
    func setData (pos: Int) {
        clickerConfirm = true
        posLoc = pos
        seePos = [0.3, 0.3, 0.3, 0.3, 0.3]
        seePos[pos] = 1.0
        checkClicker()
    }
    
    func observeClicker () {
        if self.posSelected == true {
            outputVolumeObserve = audioSession.observe(\.outputVolume) { [self] (session, value) in
                DispatchQueue.main.async {
                    self.newVolume = Double(session.outputVolume)
                    if self.newVolume > 0.5 {
                        self.hitScore = true
                        self.countShot()
                    }
                    if self.newVolume < 0.5 {
                        self.hitScore = false
                        self.countShot()
                    }
                    self.priorVolume = self.newVolume
                    self.viewSet = false
                    self.resetVolume.toggle()
                }
            }
        }
    }
    
    func checkClicker () {
        if self.clickerConfirm == true && self.scoringStarted == false {
            outputVolumeObserve = audioSession.observe(\.outputVolume) { (audioSession, changes) in
                self.clickerConfirm = false
                self.resetVolume = true
                self.outputVolumeObserve!.invalidate()
                self.posSelected = true
            }
        }
    }
    
    func turnOnClicker() {
        do {
            try audioSession.setActive(true)
        } catch {}
    }
    
    func turnOffClicker() {
        self.outputVolumeObserve?.invalidate()
        do {
            try audioSession.setActive(false)
        } catch {}
    }
}
