package razno



class WebScrapController {

    def index() {
        println "http://google.com".toURL().text
    }

    def files(){
        /*new File('nazivfajla.txt').withInputStream {in -> println in}
        def a = new File('nazivfajla.txt').withReader {r -> }
        new File('nazivfajla.txt').withOutputStream {out ->}
        new File('nazivfajla.txt').withWriter {w -> }*/
    }
}
