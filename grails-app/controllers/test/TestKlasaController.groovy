package test

import grails.converters.JSON
import net.sourceforge.tess4j.Tesseract
import net.sourceforge.tess4j.Tesseract1
import net.sourceforge.tess4j.TesseractException
import org.springframework.web.multipart.MultipartFile


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
            String text = tesseract.doOCR(new File("C:/dms/cirilica.png"))

            // path of your image file
            println text
            render text
        }
        catch (TesseractException e) {
            println e
            render e
        }
    }

    def ocrforma(){
        render view: "ocrforma"
    }

    def akcija(){

        println params

        //Tesseract1 tesseract = new Tesseract1()
        try {
            MultipartFile fajl = params.fajl
            Tesseract tesseract = new Tesseract()

            tesseract.setDatapath("C:/dms/")
            tesseract.setLanguage(params.tip as String)

            println tesseract.getProperties()
            //String text = tesseract.doOCR(new File("C:/dms/cirilica.png"))
            fajl.transferTo(new File("C:/dms/test/" + fajl.originalFilename))
            String text = tesseract.doOCR(new File("C:/dms/test/" + fajl.originalFilename))

            // path of your image file
            render ([success: true, message: "Uspjeh", text: text] as JSON)

        }
        catch (TesseractException e) {
            render ([success: true, message: e.message, text: "neuspjeh"] as JSON)
            println e
            //render e
        }
    }

}
