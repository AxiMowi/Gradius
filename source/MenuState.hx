package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;

class MenuState extends FlxState
{
	private var Player:FlxSprite;
	private var Camara:FlxObject;
	private var tilemap:FlxTilemap;
	
	override public function create():Void
	{
		super.create();
		
		var loader:FlxOgmoLoader = new FlxOgmoLoader(AssetPaths.lev1__oep);
		
		tilemap = loader.loadTilemap(AssetPaths.tilesgradius__png, 16, 16, "Tiles");
		FlxG.worldBounds.set(0, 0, loader.width, loader.height);
		
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		tilemap.setTileProperties(2, FlxObject.ANY);
		tilemap.setTileProperties(3, FlxObject.ANY);
		tilemap.setTileProperties(4, FlxObject.NONE);
		tilemap.setTileProperties(5, FlxObject.ANY);
		
		loader.loadEntities(placeEntities, "Objects");
		
		Player = new FlxSprite(32,32);
		Player.makeGraphic(16, 16, 0xFFFFFF00);
		Player.velocity.x = 64;
		
		Camara = new FlxObject();
		Camara.velocity.x = 64;
		
		FlxG.camera.setScrollBounds(0, tilemap.width, 0, tilemap.height);
		FlxG.camera.follow(Camara);
		
		add(tilemap);
		add(Player);
		add(Camara);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	    if (FlxG.keys.pressed.RIGHT) 
		{
			if (Player.x < 150) 
			{
				Player.x += 0.7;
			}
		}
		
		if (FlxG.keys.pressed.LEFT) 
		{
			if (Player.x > 0) 
			{
				Player.x -= 0.7;
			}
		}
		if (FlxG.keys.pressed.UP) 
		{
			if (Player.y < 150) 
			{
				Player.y += 0.7;
			}
		}
		
		if (FlxG.keys.pressed.DOWN) 
		{
			if (Player.y > 0) 
			{
				Player.y -= 0.7;
			}
		}
		
		FlxG.collide(tilemap, Player);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		if (entityName == "player")
		{
		Player = new FlxSprite(x, y);
		Player.makeGraphic(16, 16, 0xFFFFFF00);
		Player.velocity.x = 64;
		}
	}
}
