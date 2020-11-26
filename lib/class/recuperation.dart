class Recuperation {
  Recuperation(
      this.commune, this.quartier, this.nom, this.contact, this.observations);
  var commune;
  var quartier;
  var nom;
  var contact;
  var observations;
  var statut;
  var slug_livreur;
  var slug_structure;
  var code;
  var slug_utilisateur;
  var created_at;
  var updated_at;
  setCommune(commune) {
    this.commune = commune;
  }

  setQuartier(quartier) {
    this.quartier = quartier;
  }

  setNom(contact) {
    this.contact = contact;
  }

  setContact(contact) {
    this.contact = contact;
  }

  setObservation(observations) {
    this.observations = observations;
  }

  setLivreur(slug_livreur) {
    this.slug_livreur = slug_livreur;
  }

  setStructure(slug_structure) {
    this.slug_structure = slug_structure;
  }

  setCode(code) {
    this.code = code;
  }

  setUtilisateur(slug_utilisateur) {
    this.slug_utilisateur = slug_utilisateur;
  }

  setCreatedDate(created_at) {
    this.created_at = created_at;
  }

  setUpdatedDate(updated_at) {
    this.updated_at = updated_at;
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

  Observation() {
    return this.observations;
  }

  Livreur(slug_livreur) {
    return this.slug_livreur;
  }

  Structure(slug_structure) {
    return this.slug_structure;
  }

  Code(code) {
    return this.code;
  }

  Utilisateur(slug_utilisateur) {
    return this.slug_utilisateur;
  }

  CreatedDate(created_at) {
    return this.created_at;
  }

  UpdatedDate(updated_at) {
    return this.updated_at;
  }
}
