// this file contains a list of class objects
// the objects store different data
import 'package:multi_select_flutter/multi_select_flutter.dart';

//****************************************************/
//Filter objects class
////
class FilterObject {
  final int id;
  final String name;

  FilterObject({
    this.id = 0,
    this.name = "",
  });

  static List<MultiSelectItem<FilterObject>> areasOfDisability = [
    FilterObject(id: 1, name: "All"),
    FilterObject(id: 2, name: "Anxiety"),
    FilterObject(id: 3, name: "Autism Spectrum Disoder"),
    FilterObject(id: 4, name: "Behavioral Disorders"),
    FilterObject(id: 5, name: "Brain Injuries"),
    FilterObject(id: 6, name: "Chronic Diseases"),
    FilterObject(id: 7, name: "Cognitive Diseases"),
    FilterObject(id: 8, name: "Depression"),
    FilterObject(id: 9, name: "Developmental Disabilities"),
    FilterObject(id: 10, name: "Emotional Disorders"),
    FilterObject(id: 11, name: "Hearing Implants"),
    FilterObject(id: 12, name: "Learning Disabilities"),
    FilterObject(id: 13, name: "Mentall Illness"),
    FilterObject(id: 14, name: "Physical Disabilities"),
    FilterObject(id: 15, name: "Substance Use"),
    FilterObject(id: 16, name: "Vision Impairments"),
  ]
      .map((object) => MultiSelectItem<FilterObject>(object, object.name))
      .toList();
  static List<MultiSelectItem<FilterObject>> serviceProvided = [
    FilterObject(id: 1, name: "Domestic Violence"),
    FilterObject(id: 2, name: "Educational Services"),
    FilterObject(id: 3, name: "Employment"),
    FilterObject(id: 4, name: "Health and Dental Care"),
    FilterObject(id: 5, name: "Health and Human Services"),
    FilterObject(id: 6, name: "Homelessness"),
    FilterObject(id: 7, name: "Hospice Care"),
    FilterObject(id: 8, name: "Low-income "),
    FilterObject(id: 9, name: "Mental Health"),
    FilterObject(id: 10, name: "Newborns"),
    FilterObject(id: 11, name: "Psychological Evaluation"),
    FilterObject(id: 12, name: "Suicide Prevention"),
    FilterObject(id: 13, name: "Therapy Services"),
    FilterObject(id: 14, name: "Transportation"),
    FilterObject(id: 15, name: "Trauma"),
  ]
      .map((object) => MultiSelectItem<FilterObject>(object, object.name))
      .toList();

  static List<MultiSelectItem<FilterObject>> stateServed = [
    FilterObject(id: 1, name: "New Hampshire"),
    FilterObject(id: 2, name: "Vermont"),
  ]
      .map((object) => MultiSelectItem<FilterObject>(object, object.name))
      .toList();

  static List<MultiSelectItem<FilterObject>> insurance = [
    FilterObject(id: 1, name: "Medicare"),
    FilterObject(id: 2, name: "MedicAid"),
    FilterObject(id: 3, name: "Private"),
    FilterObject(id: 4, name: "None"),
  ]
      .map((object) => MultiSelectItem<FilterObject>(object, object.name))
      .toList();

  static List<String> convertToStringList(dynamic values) { 
    List<String> result = [];

    for (var item in values) {
      result.add(item.name);
    }

    return result;
  }
}
