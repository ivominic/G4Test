package g4test

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "testKlasa", action: "ocrforma")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
