# Heaps-Packer

Heaps-Packer is a packer spritesheet player for the [Heaps](https://heaps.io) game engine.

## Installation

- Install by running `haxelib install heaps-packer`.
- Add `-lib heaps-packer` to your project's `.hxml` file.
- Have fun!

## Usage

```haxe
import h2d.packer.Packer;

// Create your packer object via init()
var packer:Packer = new Packer(s2d);
packer.load(Res.image_png.toTile(), Res.image_txt.entry.getText());
packer.anims.add("anim", "prefix", 24, false);
packer.anims.play("anim");

// Update your packer object via update()
packer.update(dt);
```

## TODO

- [ ] Fix small clipping problems when rotating a `Sparrow`.
- [ ] Implement `addIndices` to `SparrowAnimSet`.
