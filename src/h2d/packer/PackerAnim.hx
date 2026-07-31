package h2d.packer;

using StringTools;

/**
 * A class for playing a sequence of frames for a `Packer` object.
 * The frames played depend on the `prefix` specified.
 */
class PackerAnim
{
    public var name(default, null):String;
    public var prefix(default, null):String;
    public var indices(default, null):Array<Int>;
    public var loop:Bool;
    public var framerate:Int;

    public var parent:Packer;

    public var playing(default, null):Bool;
    public var finished(default, null):Bool;

    public var currentFrame(default, set):Float;
    public var length(get, never):Int;
    
    public var reverse:Bool;

    public var onFinish:Void->Void;

    var frames:Array<PackerFrame>;

    public function new(name:String, prefix:String, indices:Array<Int>, framerate:Int, loop:Bool, parent:Packer)
    {
        this.name = name;
        this.framerate = Std.int(Math.max(0, framerate));
        this.loop = loop;

        this.parent = parent;

        this.frames = parent.frames.filter(f -> return f.name.startsWith(prefix));
        this.indices = indices;
    }

    public function update(dt:Float)
    {
        if (!playing) return;

        currentFrame += dt / (1 / framerate);

        var frame:Int = Std.int(currentFrame);

        if (reverse)
            frame = length - frame - 1;

        parent.frame = frames[indices[frame]];
    }

    public function play(reverse:Bool, frame:Int)
    {
        this.reverse = reverse;
        this.currentFrame = frame;

        playing = true;
        finished = false;
    }

    public function resume()
    {
        if (finished) return;

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
        {
            if (value >= length)
                value = 0;
            else if (value < 0)
                value = length - 1;
        }
        else
            value = Math.max(0, Math.min(length - 1, value));

        if (value >= length - 1 && !loop && playing)
        {
            stop();

            if (!finished)
            {
                finished = true;

                if (onFinish != null)
                    onFinish();
            }
        }

        return currentFrame = value;
    }

    @:noCompletion
    inline function get_length():Int
    {
        return indices.length;
    }
}