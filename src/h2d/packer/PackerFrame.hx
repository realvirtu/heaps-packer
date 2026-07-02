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

        parent.tile.dx = -width / 2;
        parent.tile.dy = -height / 2;
        
        parent.tile.setPosition(x, y);

        final width:Float = width * parent.scaleX;
        final height:Float = height * parent.scaleY;

        ctx.clipRenderZone(parent.x - width / 2, parent.y - height / 2, width, height);
        ctx.drawTile(parent, parent.tile);
        ctx.popRenderZone();
    }
}