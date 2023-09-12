class ResProfil {
  final String? nama;
  final String? mhswID;
  final String? prodi;
  final String? programID;
  final String? statusAwalID;
  final String? statusMhswID;

  ResProfil({
    required this.nama,
    required this.mhswID,
    required this.prodi,
    required this.programID,
    required this.statusAwalID,
    required this.statusMhswID,
  });

  factory ResProfil.fromJson(Map<String, dynamic> json) {
    return ResProfil(
      nama: json['Nama'],
      mhswID: json['MhswID'],
      prodi: json['Prodi'],
      programID: json['ProgramID'],
      statusAwalID: json['StatusAwalID'],
      statusMhswID: json['StatusMhswID'],
    );
  }
}


      // "Nama": "MUHAMMAD RASYID ALKAROMI",
      //   "MhswID": "2020210083",
      //   "Prodi": "TEKNIK SIPIL - S1",
      //   "ProgramID": "Reguler",
      //   "StatusAwalID": "Baru",
      //   "StatusMhswID": "Aktif"