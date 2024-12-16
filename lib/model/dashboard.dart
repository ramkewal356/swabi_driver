class CreateOnboardingModel {
  String message;
  Data data;
  bool success;

  CreateOnboardingModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory CreateOnboardingModel.fromJson(Map<String, dynamic> json) =>
      CreateOnboardingModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "success": success,
      };
}

class Data {
  String name;
  String owner;
  String creation;
  String modified;
  String modifiedBy;
  String docstatus;
  String idx;
  String positionAppliedFor;
  String name1;
  String emailId;
  String dateOfBirth;
  String gender;
  String contactP;
  String maritalStatus;
  String hobbiesInterests;
  String company;
  String currentAddress;
  String permanentAddress;
  String fathersName;
  String mothersName;
  String fathersMobNo;
  String motherMobNo;
  String otherMobNo;
  String aadharCard;
  String panCard;
  String intermediateMarksheet;
  String graduationCertificate;
  String postGraduateCertificate;
  String bankAccountDetails;
  String fresher;
  String experience;
  String motherTongue;
  String whatAreYourMajorStrengths;
  String whatDoYouThinkIsYourGreatestAchievementInLife;
  String whatDoYouThinkAreYourWeaknesses;
  String whatAreYourCareerObjectives;
  String vaccinationCertificate;
  String haveYouEverDiagnosedWithCovid;
  String doctype;
  List<BackgroundVerification> languagesKnown;
  List<AcademicRecordStartingFromHighSchool>
      academicRecordstartingFromHighSchool;
  List<dynamic> referenceListAny2NamesYouWouldLikeToReferToAcs;
  List<BackgroundVerification>
      workExperienceRecordStartWithPresentLastOrganization;
  List<BackgroundVerification> projectstrainingapprenticeshipsoftwareifAny;
  List<BackgroundVerification> backgroundVerification;

  Data({
    required this.name,
    required this.owner,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.docstatus,
    required this.idx,
    required this.positionAppliedFor,
    required this.name1,
    required this.emailId,
    required this.dateOfBirth,
    required this.gender,
    required this.contactP,
    required this.maritalStatus,
    required this.hobbiesInterests,
    required this.company,
    required this.currentAddress,
    required this.permanentAddress,
    required this.fathersName,
    required this.mothersName,
    required this.fathersMobNo,
    required this.motherMobNo,
    required this.otherMobNo,
    required this.aadharCard,
    required this.panCard,
    required this.intermediateMarksheet,
    required this.graduationCertificate,
    required this.postGraduateCertificate,
    required this.bankAccountDetails,
    required this.fresher,
    required this.experience,
    required this.motherTongue,
    required this.whatAreYourMajorStrengths,
    required this.whatDoYouThinkIsYourGreatestAchievementInLife,
    required this.whatDoYouThinkAreYourWeaknesses,
    required this.whatAreYourCareerObjectives,
    required this.vaccinationCertificate,
    required this.haveYouEverDiagnosedWithCovid,
    required this.doctype,
    required this.languagesKnown,
    required this.academicRecordstartingFromHighSchool,
    required this.referenceListAny2NamesYouWouldLikeToReferToAcs,
    required this.workExperienceRecordStartWithPresentLastOrganization,
    required this.projectstrainingapprenticeshipsoftwareifAny,
    required this.backgroundVerification,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] ?? "",
        owner: json["owner"] ?? "",
        creation: json["creation"] ?? '',
        modified: json["modified"] ?? '',
        modifiedBy: json["modified_by"] ?? "",
        docstatus: json["docstatus"].toString(),
        idx: json["idx"].toString(),
        positionAppliedFor: json["position_applied_for"] ?? "",
        name1: json["name1"] ?? '',
        emailId: json["email_id"] ?? '',
        dateOfBirth: json["date_of_birth"] ?? '',
        gender: json["gender"] ?? "",
        contactP: json["contact_p"] ?? "",
        maritalStatus: json["marital_status"] ?? "",
        hobbiesInterests: json["hobbies_interests"] ?? "",
        company: json["company"] ?? '',
        currentAddress: json["current_address"] ?? "",
        permanentAddress: json["permanent_address"] ?? "",
        fathersName: json["fathers_name"] ?? "",
        mothersName: json["mothers_name"] ?? "",
        fathersMobNo: json["fathers_mob_no"] ?? "",
        motherMobNo: json["mother_mob_no"] ?? "",
        otherMobNo: json["other_mob_no"] ?? "",
        aadharCard: json["aadhar_card"] ?? "",
        panCard: json["pan_card"] ?? "",
        intermediateMarksheet: json["intermediate_marksheet"] ?? "",
        graduationCertificate: json["graduation_certificate"] ?? "",
        postGraduateCertificate: json["post_graduate_certificate"] ?? "",
        bankAccountDetails: json["bank_account_details"] ?? "",
        fresher: json["fresher"].toString(),
        experience: json["experience"].toString(),
        motherTongue: json["mother_tongue"] ?? "",
        whatAreYourMajorStrengths: json["what_are_your_major_strengths"] ?? "",
        whatDoYouThinkIsYourGreatestAchievementInLife:
            json["what_do_you_think_is_your_greatest_achievement_in_life"] ??
                "",
        whatDoYouThinkAreYourWeaknesses:
            json["what_do_you_think_are_your_weaknesses"] ?? "",
        whatAreYourCareerObjectives:
            json["what_are_your_career_objectives"] ?? "",
        vaccinationCertificate: json["vaccination_certificate"] ?? "",
        haveYouEverDiagnosedWithCovid:
            json["have_you_ever_diagnosed_with_covid"] ?? "",
        doctype: json["doctype"] ?? "",
        languagesKnown: List<BackgroundVerification>.from(
            json["languages_known"]
                .map((x) => BackgroundVerification.fromJson(x))),
        academicRecordstartingFromHighSchool:
            List<AcademicRecordStartingFromHighSchool>.from(
                json["academic_recordstarting_from_high_school"].map(
                    (x) => AcademicRecordStartingFromHighSchool.fromJson(x))),
        referenceListAny2NamesYouWouldLikeToReferToAcs: List<dynamic>.from(
            json["reference_list_any_2_names_you_would_like_to_refer_to_acs"]
                .map((x) => x)),
        workExperienceRecordStartWithPresentLastOrganization: List<
                BackgroundVerification>.from(
            json["work_experience_record_start_with_present_last_organization"]
                .map((x) => BackgroundVerification.fromJson(x))),
        projectstrainingapprenticeshipsoftwareifAny:
            List<BackgroundVerification>.from(
                json["projectstrainingapprenticeshipsoftwareif_any"]
                    .map((x) => BackgroundVerification.fromJson(x))),
        backgroundVerification: List<BackgroundVerification>.from(
            json["background_verification"]
                .map((x) => BackgroundVerification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation,
        "modified": modified,
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "position_applied_for": positionAppliedFor,
        "name1": name1,
        "email_id": emailId,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "contact_p": contactP,
        "marital_status": maritalStatus,
        "hobbies_interests": hobbiesInterests,
        "company": company,
        "current_address": currentAddress,
        "permanent_address": permanentAddress,
        "fathers_name": fathersName,
        "mothers_name": mothersName,
        "fathers_mob_no": fathersMobNo,
        "mother_mob_no": motherMobNo,
        "other_mob_no": otherMobNo,
        "aadhar_card": aadharCard,
        "pan_card": panCard,
        "intermediate_marksheet": intermediateMarksheet,
        "graduation_certificate": graduationCertificate,
        "post_graduate_certificate": postGraduateCertificate,
        "bank_account_details": bankAccountDetails,
        "fresher": fresher,
        "experience": experience,
        "mother_tongue": motherTongue,
        "what_are_your_major_strengths": whatAreYourMajorStrengths,
        "what_do_you_think_is_your_greatest_achievement_in_life":
            whatDoYouThinkIsYourGreatestAchievementInLife,
        "what_do_you_think_are_your_weaknesses":
            whatDoYouThinkAreYourWeaknesses,
        "what_are_your_career_objectives": whatAreYourCareerObjectives,
        "vaccination_certificate": vaccinationCertificate,
        "have_you_ever_diagnosed_with_covid": haveYouEverDiagnosedWithCovid,
        "doctype": doctype,
        "languages_known":
            List<dynamic>.from(languagesKnown.map((x) => x.toJson())),
        "academic_recordstarting_from_high_school": List<dynamic>.from(
            academicRecordstartingFromHighSchool.map((x) => x.toJson())),
        "reference_list_any_2_names_you_would_like_to_refer_to_acs":
            List<dynamic>.from(
                referenceListAny2NamesYouWouldLikeToReferToAcs.map((x) => x)),
        "work_experience_record_start_with_present_last_organization":
            List<dynamic>.from(
                workExperienceRecordStartWithPresentLastOrganization
                    .map((x) => x.toJson())),
        "projectstrainingapprenticeshipsoftwareif_any": List<dynamic>.from(
            projectstrainingapprenticeshipsoftwareifAny.map((x) => x.toJson())),
        "background_verification":
            List<dynamic>.from(backgroundVerification.map((x) => x.toJson())),
      };
}

class AcademicRecordStartingFromHighSchool {
  String name;
  String owner;
  String creation;
  String modified;
  String modifiedBy;
  String docstatus;
  String idx;
  String fromMmyy;
  String toMmyy;
  String degreediplomaCompleted;
  String collageUniversity;
  String marksGrade;
  String regularCorrespondence;
  String parent;
  String parentfield;
  String parenttype;
  String doctype;
  String unsaved;

  AcademicRecordStartingFromHighSchool({
    required this.name,
    required this.owner,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.docstatus,
    required this.idx,
    required this.fromMmyy,
    required this.toMmyy,
    required this.degreediplomaCompleted,
    required this.collageUniversity,
    required this.marksGrade,
    required this.regularCorrespondence,
    required this.parent,
    required this.parentfield,
    required this.parenttype,
    required this.doctype,
    required this.unsaved,
  });

  factory AcademicRecordStartingFromHighSchool.fromJson(
          Map<String, dynamic> json) =>
      AcademicRecordStartingFromHighSchool(
        name: json["name"] ?? '',
        owner: json["owner"] ?? "",
        creation: json["creation"] ?? "",
        modified: json["modified"] ?? "",
        modifiedBy: json["modified_by"] ?? "",
        docstatus: json["docstatus"].toString(),
        idx: json["idx"].toString(),
        fromMmyy: json["from_mmyy"] ?? "",
        toMmyy: json["to_mmyy"] ?? "",
        degreediplomaCompleted: json["degreediploma_completed"] ?? "",
        collageUniversity: json["collage__university"] ?? "",
        marksGrade: json["_marks__grade"] ?? "",
        regularCorrespondence: json["regular_correspondence"] ?? "",
        parent: json["parent"] ?? "",
        parentfield: json["parentfield"] ?? "",
        parenttype: json["parenttype"] ?? "",
        doctype: json["doctype"] ?? "",
        unsaved: json["__unsaved"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation,
        "modified": modified,
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "from_mmyy": fromMmyy,
        "to_mmyy": toMmyy,
        "degreediploma_completed": degreediplomaCompleted,
        "collage__university": collageUniversity,
        "_marks__grade": marksGrade,
        "regular_correspondence": regularCorrespondence,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "doctype": doctype,
        "__unsaved": unsaved,
      };
}

class BackgroundVerification {
  String name;
  String owner;
  String creation;
  String modified;
  String modifiedBy;
  String docstatus;
  String idx;
  String? fullName;
  String? companyName;
  String? designation;
  String? contactNo;
  String parent;
  String parentfield;
  String parenttype;
  String doctype;
  String unsaved;
  String? languages;
  String? speak;
  String? readSection;
  String? write;
  String? durationFrom;
  String? durationTo;
  String? areaTopicCovered;
  String? totalExpInMonths;
  String? nameAddressOfOrganization;

  BackgroundVerification({
    required this.name,
    required this.owner,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.docstatus,
    required this.idx,
    this.fullName,
    this.companyName,
    this.designation,
    this.contactNo,
    required this.parent,
    required this.parentfield,
    required this.parenttype,
    required this.doctype,
    required this.unsaved,
    this.languages,
    this.speak,
    this.readSection,
    this.write,
    this.durationFrom,
    this.durationTo,
    this.areaTopicCovered,
    this.totalExpInMonths,
    this.nameAddressOfOrganization,
  });

  factory BackgroundVerification.fromJson(Map<String, dynamic> json) =>
      BackgroundVerification(
        name: json["name"] ?? "",
        owner: json["owner"] ?? "",
        creation: json["creation"] ?? "",
        modified: json["modified"] ?? "",
        modifiedBy: json["modified_by"] ?? "",
        docstatus: json["docstatus"].toString(),
        idx: json["idx"].toString(),
        fullName: json["full__name"] ?? "",
        companyName: json["company_name"] ?? "",
        designation: json["designation"] ?? "",
        contactNo: json["contact_no"] ?? "",
        parent: json["parent"] ?? "",
        parentfield: json["parentfield"] ?? "",
        parenttype: json["parenttype"] ?? "",
        doctype: json["doctype"] ?? "",
        unsaved: json["__unsaved"].toString(),
        languages: json["languages"] ?? "",
        speak: json["speak"].toString(),
        readSection: json["read_section"].toString(),
        write: json["write"].toString(),
        durationFrom: json["duration_from"] ?? "",
        durationTo: json["duration_to"] ?? "",
        areaTopicCovered: json["area__topic_covered"] ?? "",
        totalExpInMonths: json["total_exp_in_months"] ?? '',
        nameAddressOfOrganization: json["name__address_of_organization"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "creation": creation,
        "modified": modified,
        "modified_by": modifiedBy,
        "docstatus": docstatus,
        "idx": idx,
        "full__name": fullName,
        "company_name": companyName,
        "designation": designation,
        "contact_no": contactNo,
        "parent": parent,
        "parentfield": parentfield,
        "parenttype": parenttype,
        "doctype": doctype,
        "__unsaved": unsaved,
        "languages": languages,
        "speak": speak,
        "read_section": readSection,
        "write": write,
        "duration_from": durationFrom,
        "duration_to": durationTo,
        "area__topic_covered": areaTopicCovered,
        "total_exp_in_months": totalExpInMonths,
        "name__address_of_organization": nameAddressOfOrganization,
      };
}
