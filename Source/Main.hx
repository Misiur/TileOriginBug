package;

import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.geom.Rectangle;
import openfl.ui.Keyboard;

class Main extends Sprite
{
    public function new()
    {
        super();

        var bitmapData = Assets.getBitmapData("assets/bar.png");

        var map = new Tilemap(stage.stageWidth, stage.stageHeight);
        map.tileset = new Tileset(bitmapData);
        map.tileset.addRect(new Rectangle(0, 0, 128, 128));

        var badbox = new Tile(0, 0, 0, 1, 1, 0, 64, 64);
        badbox.x = stage.stageWidth / 2;
        badbox.y = stage.stageHeight / 2;
        map.addTile(badbox);

        var goodbox = new Tile(0, 0, 0, 1, 1, 0, 64, 64);
        goodbox.rotation = 0.01;
        goodbox.x = stage.stageWidth / 2;
        goodbox.y = stage.stageHeight / 2;
        map.addTile(goodbox);

        addChild(map);

        var speed = 0;
        
        var keys:Map<Int, Bool> = new Map();
        stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) {
            keys[e.keyCode] = false;
        });
        stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent) {
            keys[e.keyCode] = true;
        });

        var lastTime = Lib.getTimer();
        stage.addEventListener(Event.ENTER_FRAME, function(e) {
            var time = Lib.getTimer();
            var dt = (time - lastTime) / 1000;
            
            if(keys[Keyboard.D]) {
                speed = 150;
            } else if(keys[Keyboard.A]) {
                speed = -150;
            } else {
                speed = 0;
            }

            // goodbox.rotation += speed * dt;
            badbox.rotation += speed * dt;
            lastTime = time;
        });
    }
}