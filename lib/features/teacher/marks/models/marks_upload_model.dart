class MarksUploadModel {
  final String? date;
  final String? classGrade;
  final String? subject;
  final String? section;
  final String? title;
  final int? totalMarks;
  final int? recordedBy;
  final StudentMark? students;

  MarksUploadModel(
      {this.date,
      this.classGrade,
      this.subject,
      this.section,
      this.title,
      this.totalMarks,
      this.recordedBy,
      this.students});
}

class StudentMark {
  final int? studentId;
  final int? mark;
  final String? attendanceStatus;

  StudentMark({
    this.studentId,
    this.mark,
    this.attendanceStatus,
  });
}
