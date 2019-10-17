package g4test.workflowProces

class Proces {

    Procedura procedura
    String naziv
    //TODO: Provjeriti da li treba postavljati datumOd i datumDo
    Status status
    Integer redniBrojKoraka
    //TODO: Napraviti da se dodavanjem postojećeg rednog broja, svi veći ili jednaki njemu, za istu proceduru, uvećaju za 1
    Boolean mozeBitiPrekinut = true
    DokumentKlasa klasa //klasa koja pokreće proces
    Boolean active = true



    static constraints = {
    }

    String toString(){
        naziv
    }
}
