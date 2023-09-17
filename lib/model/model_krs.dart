class ModelKRS {
  String? namaProdi;
  String? linkKelas;
  String? jenisPerkuliahan;
  String? luring;
  String? daringUsername;
  String? daringPassword;
  String? daringRoom;
  String? daringHari;
  String? daringMulai;
  String? daringSelesai;
  String? kRSID;
  String? jadwalID;
  String? mKKode;
  String? sesi;
  String? namaMK;
  String? sKS;
  String? hariID;
  String? ruangID;
  String? jamKuliah;
  String? hari;
  String? dosenID;
  String? namaDosen;
  String? emailG;
  String? handphone;
  String? gelarDosen;
  String? namaKelas;

  ModelKRS({
    this.namaProdi,
    this.linkKelas,
    this.jenisPerkuliahan,
    this.luring,
    this.daringUsername,
    this.daringPassword,
    this.daringRoom,
    this.daringHari,
    this.daringMulai,
    this.daringSelesai,
    this.kRSID,
    this.jadwalID,
    this.mKKode,
    this.sesi,
    this.namaMK,
    this.sKS,
    this.hariID,
    this.ruangID,
    this.jamKuliah,
    this.hari,
    this.dosenID,
    this.namaDosen,
    this.emailG,
    this.handphone,
    this.gelarDosen,
    this.namaKelas,
  });

  ModelKRS.fromJson(Map<String, dynamic> json) {
    namaProdi = json['NamaProdi'];
    linkKelas = json['LinkKelas'];
    jenisPerkuliahan = json['JenisPerkuliahan'];
    luring = json['Luring'];
    daringUsername = json['DaringUsername'];
    daringPassword = json['DaringPassword'];
    daringRoom = json['DaringRoom'];
    daringHari = json['DaringHari'];
    daringMulai = json['DaringMulai'];
    daringSelesai = json['DaringSelesai'];
    kRSID = json['KRSID'];
    jadwalID = json['JadwalID'];
    mKKode = json['MKKode'];
    sesi = json['Sesi'];
    namaMK = json['NamaMK'];
    sKS = json['SKS'];
    hariID = json['HariID'];
    ruangID = json['RuangID'];
    jamKuliah = json['JamKuliah'];
    hari = json['Hari'];
    dosenID = json['DosenID'];
    namaDosen = json['NamaDosen'];
    emailG = json['EmailG'];
    handphone = json['Handphone'];
    gelarDosen = json['GelarDosen'];
    namaKelas = json['NamaKelas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NamaProdi'] = this.namaProdi;
    data['LinkKelas'] = this.linkKelas;
    data['JenisPerkuliahan'] = this.jenisPerkuliahan;
    data['Luring'] = this.luring;
    data['DaringUsername'] = this.daringUsername;
    data['DaringPassword'] = this.daringPassword;
    data['DaringRoom'] = this.daringRoom;
    data['DaringHari'] = this.daringHari;
    data['DaringMulai'] = this.daringMulai;
    data['DaringSelesai'] = this.daringSelesai;
    data['KRSID'] = this.kRSID;
    data['JadwalID'] = this.jadwalID;
    data['MKKode'] = this.mKKode;
    data['Sesi'] = this.sesi;
    data['NamaMK'] = this.namaMK;
    data['SKS'] = this.sKS;
    data['HariID'] = this.hariID;
    data['RuangID'] = this.ruangID;
    data['JamKuliah'] = this.jamKuliah;
    data['Hari'] = this.hari;
    data['DosenID'] = this.dosenID;
    data['NamaDosen'] = this.namaDosen;
    data['EmailG'] = this.emailG;
    data['Handphone'] = this.handphone;
    data['GelarDosen'] = this.gelarDosen;
    data['NamaKelas'] = this.namaKelas;
    return data;
  }
}
