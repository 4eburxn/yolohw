#!python

import sys, gi, signal
gi.require_version('Gst', '1.0')
gi.require_version('GstRtspServer', '1.0')
from gi.repository import Gst, GstRtspServer, GLib

Gst.init(None)

class LoopFactory(GstRtspServer.RTSPMediaFactory):
    def __init__(self, video_path):
        super().__init__()
        self.video_path = video_path
        self.pipeline = None
        
    def do_create_element(self, url):
        # Пайплайн с зацикливанием через seek
        self.pipeline = Gst.parse_launch(
            f"filesrc location={self.video_path} ! "
            "decodebin ! videoconvert ! x264enc ! rtph264pay name=pay0"
        )
        bus = self.pipeline.get_bus()
        bus.add_signal_watch()
        bus.connect("message::eos", self._on_eos)
        return self.pipeline
    
    def _on_eos(self, bus, msg):
        if self.pipeline:
            self.pipeline.seek_simple(Gst.Format.TIME, Gst.SeekFlags.FLUSH, 0)

# Запуск сервера
server = GstRtspServer.RTSPServer()
server.set_service("8554")
factory = LoopFactory(sys.argv[1] if len(sys.argv) > 1 else "video.mp4")
factory.set_shared(True)
server.get_mount_points().add_factory("/live", factory)
server.attach(None)

print(f"RTSP: rtsp://localhost:8554/live")
signal.signal(signal.SIGINT, lambda s,f: loop.quit())
loop = GLib.MainLoop()
loop.run()
