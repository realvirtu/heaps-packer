package h2d.packer;

using StringTools;

/**
 * A class for playing a sequence of frames for a `Packer` object.
 * The frames played depend on the `prefix` specified.
 */
@:access(h2d.packer.Packer)
class PackerAnim
{
    public var name(default, null):String;
    public var prefix(default, null):String;
    public var framerate:Int;
    public var loop:Bool;

    public var parent:Packer;

    public var length(get, never):Int;

    public var currentFrame:Float;
    public var reverse:Bool;

    var startIndex:Int;
    var endIndex:Int;

    public function new(name:String, prefix:String, framerate:Int, loop:Bool, parent:Packer)
    {
        this.name = name;
        this.prefix = prefix;
        this.framerate = Std.int(Math.max(0, framerate));
        this.loop = loop;

        this.parent = parent;

        final frames:Array<PackerFrame> = parent.frames;
        final animFrames:Array<PackerFrame> = frames.filter(f -> return f.name.startsWith(prefix));

        startIndex = frames.indexOf(animFrames[0]);
        endIndex = frames.lastIndexOf(animFrames[animFrames.length - 1]);
    }

    public function update(dt:Float)
    {
        final speed:Float = dt / (1 / framerate);
        final direction:Int = reverse ? -1 : 1;

        currentFrame += speed * direction;

        if (loop)
        {
            if (currentFrame < 0)
                currentFrame = length - 1;
            else if (currentFrame >= length)
                currentFrame = 0;
        }
        else
            currentFrame = Math.max(0, Math.min(length - 1, currentFrame));

        parent.setFrame(Std.int(currentFrame) + startIndex);
    }

    @:noCompletion
    inline function get_length():Int
    {
        return endIndex - startIndex + 1;
    }
}