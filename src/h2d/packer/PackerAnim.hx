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

    public var playing:Bool;
    public var reverse:Bool;

    public var currentFrame(default, set):Float;
    public var length(get, never):Int;

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
        if (!playing) return;

        currentFrame += dt / (1 / framerate);

        if (!loop && currentFrame >= length - 1)
            stop();

        var frame:Int = Std.int(currentFrame) + startIndex;

        if (reverse)
            frame = endIndex - frame;

        parent.setFrame(frame);
    }

    public function play(reverse:Bool, frame:Int)
    {
        this.reverse = reverse;
        this.currentFrame = frame;

        playing = true;
    }

    public function stop()
    {
        playing = false;
    }

    @:noCompletion
    inline function set_currentFrame(value:Float):Float
    {
        if (loop)
            value %= length;
        else
            value = Math.max(0, Math.min(length - 1, value));

        return currentFrame = value;
    }

    @:noCompletion
    inline function get_length():Int
    {
        return endIndex - startIndex + 1;
    }
}