package h2d.packer;

import haxe.ds.StringMap;

/**
 * A handler for `Packer` animation rendering.
 */
class PackerAnimSet
{
    public var anims(default, null) = new StringMap<PackerAnim>();
    public var current(default, null):PackerAnim;

    public var parent:Packer;

    public function new(parent:Packer)
    {
        this.parent = parent;
    }

    public function update(dt:Float)
    {
        if (current == null) return;

        current.update(dt);
    }

    public function add(name:String, prefix:String, framerate:Int = 24, loop:Bool = true)
    {
        anims.set(name, new PackerAnim(name, prefix, framerate, loop, parent));
    }

    public function remove(name:String)
    {
        anims.remove(name);
    }

    public function get(name:String):PackerAnim
    {
        return anims.get(name);
    }

    public function exists(name:String):Bool
    {
        return anims.exists(name);
    }

    public function play(name:String, force:Bool = false, reverse:Bool = false)
    {
        if (!exists(name) || (current?.name == name && !force)) return;

        current = anims.get(name);

        current.currentFrame = reverse ? current.length - 1 : 0;
        current.reverse = reverse;
    }

    public function stop()
    {
        current = null;
    }
}