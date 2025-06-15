# YouTube Live Streaming Plugin for OpenWRT

![OpenWRT Logo](https://openwrt.org/lib/tpl/openwrt/images/logo.png)
![YouTube Live Logo](https://www.gstatic.com/youtube/img/branding/youtubelogo/svg/youtubelogo.svg)

## 📌 Overview

This OpenWRT plugin enables live video streaming to YouTube directly from your router. It's particularly useful for:

- IP camera live streaming
- Creating DIY surveillance systems
- Low-power live streaming solutions
- Educational projects with OpenWRT

## ✨ Features

- **Web Interface**: Easy configuration via LuCI
- **Multiple Sources**: Webcam or video file input
- **Flexible Settings**: Adjustable resolution, framerate, and bitrate
- **Real-time Control**: Start/stop streaming from web interface
- **System Integration**: Runs as a proper OpenWRT service

## 📦 Installation

### Prerequisites
- OpenWRT installed on your router
- Internet connection for package installation
- USB webcam (if using webcam source)

### Installation Steps

1. Install dependencies:
   ```bash
   opkg update
   opkg install ffmpeg rtmpdump screen v4l-utils alsa-utils
   ```

2. Clone this repository to your OpenWRT build system:
   ```bash
   git clone https://github.com/yourusername/youtube-live-openwrt.git package/youtube-live
   ```

3. Include in menuconfig:
   ```bash
   make menuconfig
   ```
   - Select `youtube-live` under "Multimedia"
   - Select `youtube-live-luci` under "LuCI → 3. Applications"

4. Compile and install:
   ```bash
   make package/youtube-live/compile
   make package/youtube-live/install
   ```

## 🛠 Configuration

1. Access the web interface at: `http://your.router.ip` → Services → YouTube Live

2. Configure your stream settings:
   - YouTube Stream Key (from YouTube Studio)
   - Video Source (webcam or file)
   - Resolution and framerate
   - Audio settings

3. Use the control buttons to start/stop streaming

## 🖥 Web Interface Preview

![Settings Page](https://i.imgur.com/sample1.png)
*Configuration page in LuCI interface*

![Status Panel](https://i.imgur.com/sample2.png)
*Real-time streaming controls*

## 🐛 Troubleshooting

### Common Issues

1. **No video device found**:
   - Check if webcam is properly connected
   - Install kernel modules for your webcam:
     ```bash
     opkg install kmod-video-uvc
     ```

2. **Stream disconnects**:
   - Reduce resolution/bitrate
   - Check internet connection stability

3. **Audio not working**:
   - Verify ALSA device:
     ```bash
     arecord -l
     ```

### Checking Logs

View streaming logs:
```bash
logread -e youtube-live
```

Or via web interface in the Log Viewer tab.

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📜 License

This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- OpenWRT team
- FFmpeg developers
- LuCI maintainers

---

**Happy Streaming!** 🎥🚀
