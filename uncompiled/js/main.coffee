require.config
    paths:
        jquery: "/components/jquery/jquery"
        underscore: "/components/underscore/underscore"
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