package h2d.packer;

using StringTools;

@:access(h2d.packer.Packer)
class PackerAnim
{
    public var name(default, null):String;
    public var prefix(default, null):String;
    public var framerate:Int;
    public var looped:Bool;

    public var parent:Packer;

    public var currentFrame:Float = 0;

    var startIndex:Int;
    var endIndex:Int;

    public function new(name:String, prefix:String, framerate:Int, looped:Bool, parent:Packer)
    {
        this.name = name;
        this.prefix = prefix;
        this.framerate = framerate;
        this.looped = looped;

        this.parent = parent;

        final frames:Array<PackerFrame> = parent.frames;
        final animFrames:Array<PackerFrame> = frames.filter(f -> return f.name.startsWith(prefix));

        startIndex = frames.indexOf(animFrames[0]);
        endIndex = frames.lastIndexOf(animFrames[animFrames.length - 1]);
    }

    public function update(dt:Float)
    {
        final end:Int = endIndex - startIndex;

        currentFrame += dt / (1 / framerate);

        if (looped)
            currentFrame %= end + 1;
        else
            currentFrame = Math.min(end, currentFrame);

        parent.setFrame(Std.int(currentFrame) + startIndex);
    }
}