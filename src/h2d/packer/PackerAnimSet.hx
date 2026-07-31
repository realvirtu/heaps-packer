package h2d.packer;

import haxe.ds.StringMap;

using Lambda;
using StringTools;

/**
 * A handler for `Packer` animation rendering.
 */
class PackerAnimSet
{
    public var anims(default, null) = new StringMap<PackerAnim>();
    public var current(default, null):PackerAnim;

    public var parent:Packer;

    public var onFinish:String->Void;

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
        addIndices(name, prefix, [for (i in 0...parent.frames.count(f -> return f.name.startsWith(prefix))) i], framerate, loop);
    }

    public function addIndices(name:String, prefix:String, indices:Array<Int>, framerate:Int = 24, loop:Bool = true)
    {
        anims.set(name, new PackerAnim(name, prefix, indices, framerate, loop, parent));
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

    public function play(name:String, reverse:Bool = false, frame:Int = 0)
    {
        if (!exists(name)) return;

        current = anims.get(name);
        current.play(reverse, frame);

        current.onFinish = () -> {
            if (onFinish != null)
                onFinish(current.name);
        }
    }

    public function stop()
    {
        if (current == null) return;

        current.stop();
    }
}