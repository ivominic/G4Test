package g4test.workflowProces

class Korak {

    Proces proces
    String naziv
    Integer redniBrojKoraka
    Boolean generisanjeNovogDokumenta = false
    Proces noviProces //Ili bi ovdje trebalo da ukazuje na drugi korak
    String kontroler = ""
    String metoda = ""
    //Grupe korisnika kojima se prosljeđuje dokument
    //Atributi koji moraju biti popunjeni
    //Vrijednosti atributa od kojih zavisi granjanje, tj kad će se preći na koji korak/proces da bude navedeno u ovoj vezi/klasi


    static constraints = {
        noviProces nullable: true //ili postaviti da je novi proces isti proces ako se ne mijenja
        kontroler nullable: true, blank: true
        metoda nullable: true, blank: true
    }

    String toString(){
        naziv
    }
}
