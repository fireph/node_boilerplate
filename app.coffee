#require stylus
stylus = require("stylus")
nib = require("nib")

#require coffeescript
coffeeScript = require("coffee-script")
connectCoffeescript = require("connect-coffee-script")

#config file
config = require("./conf")

#set production environment variable
process.env.NODE_ENV = config.node_env

#express + socket.io
express = require("express")
app = express()
http = require("http")
server = http.createServer(app)
sio = require("socket.io")
io = sio.listen(server)

#set socket.io log level 1-3
io.set "log level", 1
io.enable "browser client minification"
#doesn't work in windows :(
#io.enable "browser client gzip"
io.enable "browser client etag"

#jade
jade = require("jade")

#config express
app.configure ->
    app.use express.compress()
    app.set "views", __dirname + "/views"
    app.set "view engine", "jade"
    app.use express.cookieParser()
    app.use express.bodyParser()
    app.use express.session(
        secret: "sessiontestappsecret"
    )
    app.use stylus.middleware(
        src: __dirname + "/uncompiled" # .styl files are located in `uncompiled/css`
        dest: __dirname + "/static" # .styl resources are compiled `static/css/*.css`
        compile: (str, path) -> # optional, but recommended
            stylus(str).set("filename", path).set("compress", true).use(nib())
    )
    app.use connectCoffeescript(
        src: __dirname + "/uncompiled" # .coffee files are located in `uncompiled/js`
        dest: __dirname + "/static" # .coffee resources are compiled `static/js/*.js`
        compile: (str, options) -> # optional, but recommended
            options.bare = true
            coffeeScript.compile(str, options)
    )
    app.use express.static(__dirname + "/static")
    app.use app.router

#mongoskin
mongo = require("mongoskin")
db = mongo.db("localhost:27017/"+config.mongoDatabase+"?auto_reconnect", {safe: true})

app.get "/", (req, res) ->
    res.render "index",
        title: "testPage"
        layout: "layout"

io.sockets.on "connection", (socket) ->
    socket.on "testEvent", (data) ->
        console.log "Test event fired on server!"
    socket.on "disconnect", ->
        console.log "User disconnected."

console.log "Running server in mode: " + app.settings.env

server.listen config.expressPort
console.log "Express on port: " + config.expressPort