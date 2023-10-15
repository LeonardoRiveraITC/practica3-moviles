class HomeworkModel {
  int? idHomework;
  String? nameHomework;
  String? expireDate;
  String? notifyDate;
  String? descHomework;
  int? done;
  int? idProfessor;

  HomeworkModel(
      {this.idHomework,
      this.nameHomework,
      this.expireDate,
      this.notifyDate,
      this.descHomework,
      this.done,
      this.idProfessor});
  factory HomeworkModel.fromMap(Map<String, dynamic> map) {
    return HomeworkModel(
        idHomework: map['idHomework'],
        expireDate: map['expireDate'],
        notifyDate: map['notifyDate'],
        descHomework: map['descHomework'],
        done: map['done'],
        idProfessor: map['idProfessor']);
  }
}
