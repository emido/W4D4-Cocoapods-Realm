//
//  RealmViewController.swift
//  Realm-Cocoapods
//
//  Created by steve on 2018-02-08.
//  Copyright © 2018 steve. All rights reserved.
//

import UIKit
import RealmSwift


class Dog: Object {
  @objc dynamic var name: String? // set to nil automatically
  let age = RealmOptional<Int>()
}

class Person: Object {
  @objc dynamic var name = ""
  @objc dynamic var picture: Data? = nil // optionals supported
  let dogs = List<Dog>() // models a one to many relationship
}

final class DataManager {
  
  static func createDog(with name: String, and age: Int? = nil)-> Dog {
    let dog = Dog()
    dog.name = name
    dog.age.value = age
    return dog
  }
  
  static func createPerson(with name: String, and image: UIImage? = nil)-> Person {
    let person = Person()
    person.name = name
    if let image = image {
      person.picture = UIImageJPEGRepresentation(image, 1.0)
    }
    return person
  }
  
  static func save<T: Object>(object: T) {
    do {
      let realm = try Realm()
      try realm.write {
        // Add to the realm inside a write transaction
        realm.add(object)
      }
    } catch {
      print(#line, error.localizedDescription)
    }
  }
  
  static func fetchPersons()-> Results<Person> {
    let realm = try! Realm()
    let results = realm.objects(Person.self)
    // loop through result set
    return results
  }
  
  static func fetchWithFilter()-> Results<Dog> {
    let realm = try! Realm()
    let predicate = NSPredicate(format:"age > 1")
    let results = realm.objects(Dog.self).filter(predicate)
    return results
  }
}

class RealmViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //    var name = "Dino"
    //    let dog = DataManager.createDog(with: name)
    //    // To assign to RealmOptional use .value property
    //    dog.age.value = 2
    //
    //    name = "Fred"
    //    let image = UIImage(named: "fred.jpeg")
    //    let person = DataManager.createPerson(with: name, and: image)
    //    person.dogs.append(dog)
    //    DataManager.save(object: person)
    //
    //
    //    let results = DataManager.fetchPersons()
    //    for person in results {
    //      print(#line, person.name)
    //      print(#line, person.dogs.first?.name ?? "no dog or no name")
    //    }
    
    //  }
    
    //    let results = DataManager.fetchWithFilter()
    //    for dog in results {
    //      print(#line, dog.name ?? "no name set")
    //    }
    
    
//    let realm = try! Realm()
//
//    try! realm.write {
//      let results = DataManager.fetchWithFilter()
//      guard let dog = results.first else { return }
//      dog.age.value = dog.age.value! + 1
//    }
    
    
    
    //    private func fetchWithFilter()-> Dog? {
    //      let predicate = NSPredicate(format:"age > 1")
    //      let results = realm.objects(Dog.self).filter(predicate)
    //      return results.first
    //    }
    
    //    realm.write {
    //      guard let dog = fetchWithFilter() else { return }
    //      dog.age.value = dog.age.value + 1
    //    }
    
    
    let realm = try! Realm()
//
//    func deleteObject() {
//      guard let dog = DataManager.fetchWithFilter().first else { return }
//      try! realm.write {
//        realm.delete(dog)
//      }
//    }
//
//    deleteObject()
    
    func deleteAllPeople() {
      // Pass the `Results` directly to delete everything fetched.
      try! realm.write {
        realm.delete(realm.objects(Person.self))
      }
    }
    
    deleteAllPeople()
  }
  
}
