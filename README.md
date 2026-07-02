# Heaps-Packer

Heaps-Packer is a packer spritesheet player for the [Heaps](https://heaps.io) game engine.

## Installation

Please note that there is no Haxelib page currently, so this must be installed through git.

- Install by running `haxelib install heaps-packer https://github.com/realvirtu/heaps-packer`.
    - When using `hmm`, run `hmm git heaps-packer https://github.com/realvirtu/heaps-packer` (recommended).
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