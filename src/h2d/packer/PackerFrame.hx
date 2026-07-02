package h2d.packer;

class PackerFrame
{
    public var name:String;
    public var x:Int;
    public var y:Int;
    public var width:Int;
    public var height:Int;

    public var parent:Packer;

    public function new(name:String, x:Int, y:Int, width:Int, height:Int, parent:Packer)
    {
        this.name = name;
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        this.parent = parent;
    }

    public function draw(ctx:RenderContext)
    {
        if (parent.tile == null) return;

        parent.tile.dx = -x;
        parent.tile.dy = -y;

        ctx.clipRenderZone(parent.x, parent.y, width * parent.scaleX, height * parent.scaleY);
        ctx.drawTile(parent, parent.tile);
        ctx.popRenderZone();
    }
}