package h2d.packer;

/**
 * A single frame of a `Packer` object. The rendering of a `Packer` is handled here.
 */
@:access(h2d.packer.Packer)
class PackerFrame
{
    public var name:String;
    public var x:Int;
    public var y:Int;
    public var width:Int;
    public var height:Int;

    public var parent:Packer;

    var tile:Tile;

    public function new(name:String, x:Int, y:Int, width:Int, height:Int, parent:Packer)
    {
        this.name = name;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        this.parent = parent;

        if (parent.tile == null) return;

        tile = parent.tile.sub(x, y, width, height);
        tile.dx = -width / 2;
        tile.dy = -height / 2;
        tile.setPosition(x, y);
    }

    public function draw(ctx:RenderContext)
    {
        if (tile == null) return;

        ctx.drawTile(parent, tile);
    }
}