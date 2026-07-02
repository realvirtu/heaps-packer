package h2d.packer;

import haxe.ds.StringMap;

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

    public function add(name:String, prefix:String, framerate:Int = 24, looped:Bool = true)
    {
        anims.set(name, new PackerAnim(name, prefix, framerate, looped, parent));
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

    public function play(name:String)
    {
        if (!exists(name)) return;

        current = anims.get(name);
        current.currentFrame = 0;
    }

    public function stop()
    {
        current = null;
    }
}