//  DBManager.swift
//  Lexicon
//
//  Created by Minh on 11/28/16.
//  Copyright © 2016 Lexicon. All rights reserved.
//

import Foundation
import RealmSwift


class DBManager {
    
    let realm = try! Realm()
    
    func getAnimals(completion: @escaping ([Animal]) -> Void) {
        // async update animals from the server
        updateAnimals {[weak self] in
            
            guard let `self` = self else {
                return
            }
            
            let animals = Array(self.realm.objects(Animal.self))
            completion(animals)
        }
        
        let animals = Array(realm.objects(Animal.self))
        
        completion(animals)
    }
    
    
    
    func getAnimalClass(completion: @escaping ([AnimalClass]) -> Void) {
        // async update animals from the server
        updateAnimalClass() {[weak self] in
            
            guard let `self` = self else {
                return
            }
            
            let animalClass = Array(self.realm.objects(AnimalClass.self))
            completion(animalClass)
        }
        
        let animalClass = Array(realm.objects(AnimalClass.self))
        
        completion(animalClass)
    }
    
    func getContinentRelationShip(completion: @escaping ([ContinentRelation]) -> Void) {
        let relations = Array(realm.objects(ContinentRelation.self))
        completion(relations)
        
        updateContinentRelations() {[weak self] in
            guard let `self` = self else { return }
            
            let relations = Array(self.realm.objects(ContinentRelation.self))
            completion(relations)
        }
    }
    
    func getFoodRelationShip(completion: @escaping ([FoodRelation]) -> Void) {
        let relations = Array(realm.objects(FoodRelation.self))
        completion(relations)
        
        updateFoodRelations() {[weak self] in
            guard let `self` = self else { return }
            
            let relations = Array(self.realm.objects(FoodRelation.self))
            completion(relations)
        }
    }
    
    func getAnimalListWithClassID(id: Int) -> [Animal] {
        return Array(self.realm.objects(Animal.self).filter("animalClass = %d", id))
        
    }
    
    
    func getAnimalListWithID(ids: [Int]) -> [Animal] {
        return Array(self.realm.objects(Animal.self).filter("id IN %d", ids))

    }
  
        
    private func updateAnimalClass(completion: (() -> Void)? = nil) {
        API.communicator.getAllAnimalClassRequest{(success, response) in
            
            guard success, let response = response else {
                return
            }
            
            
            let animals = response["result"]["records"].arrayValue.map { (json) -> AnimalClass in
                return  AnimalClass.new(json: json)
            }
            
            
            let realm = try! Realm()
            
            try! realm.write {
                for animal in animals {
                    _ = log.message("Adding new animal class to the database \(animal)")
                    realm.add(animal)
                }
                
                completion?()
            }
            
            
            }.addToAPIQueue()
    }
    
    private func updateAnimals(completion: (() -> Void)? = nil) {
        API.communicator.getAllAnimalsRequest {(success, response) in
            
            guard success, let response = response else {
                return
            }
            
            
            let animals = response["result"]["records"].arrayValue.map { (json) -> Animal in
                return  Animal.new(json: json)
            }
            
            
            let realm = try! Realm()
            
            try! realm.write {
                for animal in animals {
                    _ = log.message("Adding new animal to the database \(animal)")
                    realm.add(animal)
                }
                
                completion?()
            }
            
            
        }.addToAPIQueue()
    }
    
    
    private func updateContinentRelations(completion: (() -> Void)? = nil) {
        API.communicator.getContinentRelations {(success, response) in
            guard success, let response = response else {
                return
            }
            
            let relations = response["result"]["records"].arrayValue.map { (json) -> ContinentRelation in
                return  ContinentRelation.new(json: json)
            }
            
            let realm = try! Realm()
            
            try! realm.write {
                for relation in relations {
                    //                    _ = log.message("Adding new animal to the database \(animal)")
                    realm.add(relation)
                }
                
                completion?()
            }
            
            
            }.addToAPIQueue()
    }

    private func updateFoodRelations(completion: (() -> Void)? = nil) {
        API.communicator.getFoodRelations {(success, response) in
            guard success, let response = response else {
                return
            }
            
            let relations = response["result"]["records"].arrayValue.map { (json) -> FoodRelation in
                return  FoodRelation.new(json: json)
            }
            
            let realm = try! Realm()
            
            try! realm.write {
                for relation in relations {
                    //                    _ = log.message("Adding new animal to the database \(animal)")
                    realm.add(relation)
                }
                
                completion?()
            }
            
            
            }.addToAPIQueue()
    }

}
