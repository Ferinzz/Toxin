# Silly not very precise benchmark

There's a lot of variations in the way this benchmark is setup, but had fun making this work.
Written while the new Toxin rework is underway, so a lot of extra imports and direct calls to the gdAPI. Maybe that makes it slightly faster since there's no extra in-between procedure call.
Texture resource is loaded once during registration of the class. After that the same one is assigned to each texture.
Couldn't get window info, seems like I'm asking for the wrong object info. Oh well.
https://github.com/quaadgras/graphics.gd/discussions/268