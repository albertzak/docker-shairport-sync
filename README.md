# Shairport Sync on Resin

[shairport-sync](https://github.com/mikebrady/shairport-sync) is an Apple AirPlay receiver. It can receive audio directly from iOS devices, iTunes, etc. Multiple instances of shairport-sync will stay in sync with each other and other AirPlay devices when used with a compatible multi-room player, such as iTunes or [forked-daapd](https://github.com/jasonmc/forked-daapd).

This project is based on the Dockerfile of [kevineye/shairport-sync](https://github.com/kevineye/shairport-sync) to run on [Resin.io](https://resin.io).


## Run

```
git clone https://github.com/albertzak/resin-shairport-sync
cd resin-shairport-sync
git remote add resin <your-resin-url>
git push resin
```

### Parameters

Set the following environment variables thorugh the Resin control panel

* `AIRPLAY_NAME` (Default: Docker) Change this to anything you want.
* `OUTPUT_NAME` (Default: Speaker) Don't change this unless there is no sound.  It should work automatically through either the built-in 3.5mm jack, or most cheap USB sound cards such as those "3D Sound" ones. Use `amixer` or `alsamixer` or similar to discover the name of the output sound card.
