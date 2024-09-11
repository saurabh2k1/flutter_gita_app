class Verse {
  String? sId;
  int? chapter;
  int? verse;
  String? slok;
  String? transliteration;
  Author? tej;
  Author? siva;
  Author? purohit;
  Author? chinmay;
  Author? san;
  Author? adi;
  Author? gambir;
  Author? madhav;
  Author? anand;
  Author? rams;
  Author? raman;
  Author? abhinav;
  Author? sankar;
  Author? jaya;
  Author? vallabh;
  Author? ms;
  Author? srid;
  Author? dhan;
  Author? venkat;
  Author? puru;
  Author? neel;
  Author? prabhu;

  Verse(
      {this.sId,
      this.chapter,
      this.verse,
      this.slok,
      this.transliteration,
      this.tej,
      this.siva,
      this.purohit,
      this.chinmay,
      this.san,
      this.adi,
      this.gambir,
      this.madhav,
      this.anand,
      this.rams,
      this.raman,
      this.abhinav,
      this.sankar,
      this.jaya,
      this.vallabh,
      this.ms,
      this.srid,
      this.dhan,
      this.venkat,
      this.puru,
      this.neel,
      this.prabhu}
    );

  Verse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chapter = json['chapter'];
    verse = json['verse'];
    slok = json['slok'];
    transliteration = json['transliteration'];
    tej = json['tej'] != null ? Author.fromJson(json['tej']) : null;
    siva = json['siva'] != null ? Author.fromJson(json['siva']) : null;
    purohit = json['purohit'] != null ? Author.fromJson(json['purohit']) : null;
    chinmay = json['chinmay'] != null ? Author.fromJson(json['chinmay']) : null;
    san = json['san'] != null ? Author.fromJson(json['san']) : null;
    adi = json['adi'] != null ? Author.fromJson(json['adi']) : null;
    gambir = json['gambir'] != null ? Author.fromJson(json['gambir']) : null;
    madhav = json['madhav'] != null ? Author.fromJson(json['madhav']) : null;
    anand = json['anand'] != null ? Author.fromJson(json['anand']) : null;
    rams = json['rams'] != null ? Author.fromJson(json['rams']) : null;
    raman = json['raman'] != null ? Author.fromJson(json['raman']) : null;
    abhinav = json['abhinav'] != null ? Author.fromJson(json['abhinav']) : null;
    sankar = json['sankar'] != null ? Author.fromJson(json['sankar']) : null;
    jaya = json['jaya'] != null ? Author.fromJson(json['jaya']) : null;
    vallabh = json['vallabh'] != null ? Author.fromJson(json['vallabh']) : null;
    ms = json['ms'] != null ? Author.fromJson(json['ms']) : null;
    srid = json['srid'] != null ? Author.fromJson(json['srid']) : null;
    dhan = json['dhan'] != null ? Author.fromJson(json['dhan']) : null;
    venkat = json['venkat'] != null ? Author.fromJson(json['venkat']) : null;
    puru = json['puru'] != null ? Author.fromJson(json['puru']) : null;
    neel = json['neel'] != null ? Author.fromJson(json['neel']) : null;
    prabhu = json['prabhu'] != null ? Author.fromJson(json['prabhu']) : null;
  }
}

class Author {
  String name;
  String? ht;
  String? et;
  String? hc;
  String? ec;
  String? sc;

  Author({
    required this.name,
    this.ht,
    this.et,
    this.hc,
    this.ec,
    this.sc,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['author'],
      ht: json['ht'],
      et: json['et'],
      hc: json['hc'],
      ec: json['ec'],
      sc: json['sc'],
    );
  }
}
