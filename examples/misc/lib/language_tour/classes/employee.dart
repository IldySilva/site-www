// ignore_for_file: strict_raw_type, use_super_parameters

Map fetchDefaultData() => {}; // stub

// #docregion super
class Person {
  String? firstName;

  Person.fromJson(Map data) {
    print('in Person');
  }
}

// #docregion method-then-constructor
class Employee extends Person {
  // #enddocregion super
  Employee() : super.fromJson(fetchDefaultData());
  // #enddocregion method-then-constructor
  // #docregion super
  // Person does not have a default constructor;
  // you must call super.fromJson().
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }
  // #docregion method-then-constructor
}
// #enddocregion method-then-constructor

void main() {
  var employee = Employee.fromJson({});
  print(employee);
  // Prints:
  // in Person
  // in Employee
  // Instance of 'Employee'
  // #enddocregion super
  // #docregion emp-is-person
  // ignore: unnecessary_type_check
  if (employee is Person) {
    // Type check
    employee.firstName = 'Bob';
  }
  // #enddocregion emp-is-person
  // #docregion emp-as-person
  (employee as Person).firstName = 'Bob';
  // #enddocregion emp-as-person
  // #docregion super
}

// #enddocregion super
