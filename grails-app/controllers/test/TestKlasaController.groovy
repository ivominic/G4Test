package test

import net.sourceforge.tess4j.Tesseract
import net.sourceforge.tess4j.Tesseract1
import net.sourceforge.tess4j.TesseractException


class TestKlasaController {


    def index() {
    }

    def gridStore(){
        return []
    }

    def ocr(){
        Tesseract tesseract = new Tesseract()
        //Tesseract1 tesseract = new Tesseract1()
        try {

            tesseract.setDatapath("C:/dms/")
            tesseract.setLanguage("srp_latn_new")

            println tesseract.getProperties()

            // the path of your tess data folder
            // inside the extracted file
            //String text = tesseract.doOCR(new File("test.png"))
            //String text = tesseract.doOCR(new File("C:/dms/test1.png"))
            String text = tesseract.doOCR(new File("C:/dms/tabela.pdf"))

            // path of your image file
            println text
            render text
        }
        catch (TesseractException e) {
            println e
            render e
        }
    }

}
