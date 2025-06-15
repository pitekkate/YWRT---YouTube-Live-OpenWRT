module("luci.controller.youtube-live", package.seeall)

function index()
    if not nixio.fs.access("/etc/config/youtube-live") then
        return
    end
    
    entry({"admin", "services", "youtube-live"}, cbi("youtube-live/settings"), _("YouTube Live"), 60).dependent = true
    entry({"admin", "services", "youtube-live", "action"}, call("action")).leaf = true
    entry({"admin", "services", "youtube-live", "log"}, call("get_log")).leaf = true
end

function action()
    local http = require "luci.http"
    local sys = require "luci.sys"
    
    local cmd = http.formvalue("cmd")
    
    if cmd == "start" then
        http.write(sys.exec("/usr/bin/youtube-live start 2>&1"))
    elseif cmd == "stop" then
        http.write(sys.exec("/usr/bin/youtube-live stop 2>&1"))
    elseif cmd == "status" then
        http.write(sys.exec("/usr/bin/youtube-live status 2>&1"))
    else
        http.status(400, "Bad Request")
        http.write("Invalid command")
    end
end

function get_log()
    local http = require "luci.http"
    local fs = require "nixio.fs"
    
    local log_file = "/tmp/youtube-live.log"
    
    if fs.access(log_file) then
        http.prepare_content("text/plain")
        http.write(fs.readfile(log_file) or "Log file is empty")
    else
        http.status(404, "Not Found")
        http.write("Log file not found")
    end
end
