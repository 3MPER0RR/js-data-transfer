JS Data Transfer

Lightweight, zero-setup file transfer tool for multi-machine lab environments.

JS Data Transfer eliminates the repetitive overhead of spinning up a file server every time you need to move data between machines in a lab. Drop a single file on the host machine, run one command, and every other machine on the network can immediately send and receive files through the browser — no installation required on the client side.

Features

Single-file bundle — js-data-transfer.js is a self-contained 1.7 MB Node.js bundle. No npm install, no dependencies to manage after the first deployment.
Zero client setup — client machines only need a browser. No software installation required.
Automatic port selection — if the default port is busy, the server finds the next available one automatically.
QR code on startup — the terminal prints a QR code pointing to the server URL, so connecting from a phone or tablet is instant.
Real-time updates — file list refreshes automatically via WebSocket whenever a new file is received.
Multi-client chat — lightweight real-time chat between all connected devices, useful during lab sessions.
REST API — all operations (upload, download, list, delete) are available as JSON endpoints, enabling scripting and automation via curl or any HTTP client.
P2P mode — js-data-transfer-p2p.html provides direct browser-to-browser file transfer via WebRTC, with no server required at all.


Files
FileDescriptionjs-data-transfer.jsSelf-contained server bundle. The only file you need for LAN mode.start.shOptional shell wrapper. Validates the Node.js version before launching.js-data-transfer-p2p.htmlStandalone P2P interface. Open in any browser, no server required.

Quick Start
LAN Mode 
Node.js v16 or later must be installed on the host machine. No other prerequisites.
bash# Start on default port (7373)
node js-data-transfer.js

# Start on a custom port
node js-data-transfer.js 8080

# Or use the wrapper script
bash start.sh
On startup, the terminal displays all available IP addresses and a QR code. Open the printed URL from any machine on the same network to access the interface.
Files received from clients are saved to ./received_files/ in the directory where the server was started.
P2P Mode (no server, no shared network required)
Open js-data-transfer-p2p.html in a browser on both machines and follow the three-step connection flow:

Sender clicks Generate Offer and shares the resulting string with the receiver.
Receiver pastes the offer, clicks Accept & Generate Answer, and shares the answer string back.
Sender pastes the answer and clicks Connect. The peer-to-peer channel is established.

Once connected, file transfers happen directly between the two browsers with no intermediary.
Sending files via curl
The REST API accepts standard HTTP requests, making it easy to integrate into scripts:
bash# Upload a file
curl -F 'files=@filetest.bin' http://192.168.1.50:7373/api/upload

# List received files
curl http://192.x.x.x:7373/api/download/filename.bin

# Download a file
curl -O http://192.x.x.x:7373/api/download/filename.bin

# Delete a file
curl -X DELETE http://192.x.x.x:7373/api/files/filename.bin

API Reference
MethodEndpointDescriptionGET/api/infoHost info: hostname, IPs, platform, uptimeGET/api/filesList all received files (name, size, timestamp)POST/api/uploadUpload one or more files (multipart/form-data)GET/api/download/:nameDownload a file by nameDELETE/api/files/:nameDelete a file by nameGET/api/logFull transfer log for the current session

LAN vs P2P — When to Use Which
LAN ModeP2P WebRTCPrerequisitesNode.js on hostBrowser onlyNumber of clientsUnlimited2Shared network requiredYesNoFiles saved to diskYes (automatic)No (manual download)Real-time chatYesNoBest forMulti-machine lab sessionsQuick two-machine transfers

Security Notice
JS Data Transfer does not implement authentication or encryption. It is designed for use on trusted, isolated lab networks. Do not expose the service on public-facing interfaces.

Requirements

LAN mode: Node.js v16 or later on the host machine.
P2P mode: Any modern browser (Chrome, Firefox, Edge) on both machines. WebRTC must not be blocked by the network.
