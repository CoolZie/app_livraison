class Livraison {
  var commune;
  var quartier;
  var nom;
  var contact;
  var nature;
  var montant;
  setCommune(commune) {
    this.commune = commune;
  }

  setQuartier(quartier) {
    this.quartier = quartier;
  }

  setNom(nom) {
    this.nom = nom;
  }

  setContact(contact) {
    this.contact = contact;
  }

  setNature(nature) {
    this.nature = nature;
  }

  setMontant(montant) {
    this.montant = montant;
  }

  Commune() {
    return this.commune;
  }

  Quartier() {
    return this.quartier;
  }

  Nom() {
    return this.contact;
  }

  Contact() {
    return this.contact;
  }

  Nature() {
    return this.nature;
  }

  Montant() {
    return this.montant;
  }

  Map toJson() => {
        'commune': this.commune,
        'quartier': this.quartier,
        'nom': this.nom,
        'contact': this.contact,
        'nature': this.nature,
        'montant': this.montant,
      };
}
