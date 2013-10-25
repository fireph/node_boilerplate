require.config
    paths:
        jquery: [
            "//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min"
            "/components/jquery/jquery.min"
        ]
        underscore: [
            "//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.5.2/underscore-min"
            "/components/underscore/underscore-min"
        ]
        angular: [
            "//ajax.googleapis.com/ajax/libs/angularjs/1.0.8/angular.min"
            "/components/angular/angular.min"
        ]
        util: "/js/lib/util"
    shim:
        jquery:
            exports: "$"
        underscore:
            exports: "_"
        angular:
            exports: "angular"

require ["jquery", "underscore", "angular", "util"], ($, _, angular, util) ->
    #Code that needs jquery and underscore and util goes here.
    socket = io.connect "/"
    socket.on "connect", () ->
        console.log "Connected to server with socket.io!"
    socket.on "testEvent", (data) ->
        console.log "Test event fired on client!"