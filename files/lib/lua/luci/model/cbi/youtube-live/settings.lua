local uci = require "luci.model.uci".cursor()
local sys = require "luci.sys"
local fs = require "nixio.fs"

m = Map("youtube-live", translate("YouTube Live Streaming Settings"), 
        translate("Configure your YouTube live streaming parameters. Get your stream key from YouTube Studio."))

s = m:section(TypedSection, "config", translate("Stream Settings"))
s.anonymous = true
s.addremove = false

-- YouTube Stream Key
o = s:option(Value, "stream_key", translate("YouTube Stream Key"))
o.password = true
o.rmempty = false
o.description = translate("Get this from YouTube Studio > Go Live")

-- Video Source
o = s:option(ListValue, "video_source", translate("Video Source"))
o:value("webcam", translate("Webcam"))
o:value("file", translate("Video File"))
o.default = "webcam"
o.rmempty = false

-- Video File Path
o = s:option(Value, "video_file", translate("Video File Path"))
o:depends("video_source", "file")
o.default = "/path/to/video.mp4"
o.description = translate("Full path to video file for streaming")

-- Resolution
o = s:option(ListValue, "resolution", translate("Resolution"))
o:value("640x480", "640x480 (SD)")
o:value("1280x720", "1280x720 (HD)")
o:value("1920x1080", "1920x1080 (Full HD)")
o.default = "1280x720"
o.rmempty = false

-- Frame Rate
o = s:option(ListValue, "framerate", translate("Frame Rate"))
o:value("24", "24 fps")
o:value("30", "30 fps")
o:value("60", "60 fps")
o.default = "30"
o.rmempty = false

-- Bitrate
o = s:option(ListValue, "bitrate", translate("Video Bitrate"))
o:value("1500k", "1.5 Mbps (Low)")
o:value("3000k", "3 Mbps (Medium)")
o:value("5000k", "5 Mbps (High)")
o:value("8000k", "8 Mbps (Very High)")
o.default = "3000k"
o.rmempty = false

-- Audio Source
o = s:option(ListValue, "audio_source", translate("Audio Source"))
o:value("alsa", "ALSA (Sound Card)")
o:value("none", "No Audio")
o.default = "alsa"
o.rmempty = false

-- Status and Control Section
s = m:section(SimpleSection)
s.template = "youtube-live/status_control"

-- Log Section
s = m:section(SimpleSection)
s.template = "youtube-live/log_viewer"

return m
