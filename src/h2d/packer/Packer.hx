package h2d.packer;

using StringTools;

class Packer extends Drawable
{
    public var tile:Tile;
    public var anims:PackerAnimSet;

    var frames:Array<PackerFrame>;
    var frame:PackerFrame;
    
    public function new(?parent:Object)
    {
        super(parent);

        anims = new PackerAnimSet(this);
    }

    public function update(dt:Float)
    {
        anims.update(dt);
    }

    public function load(tile:Tile, data:String)
    {
        this.tile = tile;

        frames = [];
        frame = null;

        final anims:Array<String> = data.trim().split('\n');

        if (anims == null) return;

        for (anim in anims)
        {
            final info:Array<String> = anim.split('=');
            final name:String = info[0]?.trim();
            final data:Array<String> = info[1]?.trim()?.split(' ');

            if (data == null) continue;

            final x:Int = Std.parseInt(data[0]);
            final y:Int = Std.parseInt(data[1]);
            final width:Int = Std.parseInt(data[2]);
            final height:Int = Std.parseInt(data[3]);

            frames.push(new PackerFrame(name, x, y, width, height, this));
        }

        setFrame(0);
    }

    public function setFrame(index:Int)
    {
        if (frames.length == 0) return;

        index = Std.int(Math.max(0, Math.min(frames.length - 1, index)));
        frame = frames[index];
    }

    override function draw(ctx:RenderContext)
    {
        if (frame == null) return;

        frame.draw(ctx);
    }
}