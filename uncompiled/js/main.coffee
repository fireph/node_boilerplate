require.config
    paths:
        jquery: [
            "//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min"
            "/components/jquery/jquery"
        ]
        underscore: [
            "//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.1/underscore-min"
            "/components/underscore/underscore"
        ]
        util: "/js/lib/util"
    shim:
        jquery:
            exports: "$"
        underscore:
            exports: "_"

require ["jquery", "underscore", "util"], ($, _, util) ->
    #Code that needs jquery and underscore and util goes here.
    socket = io.connect "/"
    socket.on "connect", () ->
        console.log "Connected to server with socket.io!"
    socket.on "testEvent", (data) ->
        console.log "Test event fired on client!"