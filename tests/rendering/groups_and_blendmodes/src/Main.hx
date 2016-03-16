
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Batcher;

class Main extends luxe.Game {


    var level_sprite : Sprite;

    var luxe_sprite1 : Sprite;
    var luxe_sprite2 : Sprite;
    var luxe_sprite3 : Sprite;

    var batch1 : Batcher;
    var batch2 : Batcher;
    var batch3 : Batcher;

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({ id:'assets/level.png' });
        config.preload.textures.push({ id:'assets/luxe.png' });

        return config;

    } //config


    override function ready() {

        batch1 = Luxe.renderer.create_batcher({ name:'batch1', camera:Luxe.camera.view });
        batch2 = Luxe.renderer.create_batcher({ name:'batch2', camera:Luxe.camera.view });
        batch3 = Luxe.renderer.create_batcher({ name:'batch3', camera:Luxe.camera.view });

        var level_texture = Luxe.resources.texture('assets/level.png');
        var luxe_texture = Luxe.resources.texture('assets/luxe.png');

        level_sprite = new Sprite({
            texture : level_texture,
            pos : new Vector(Luxe.screen.w/2,Luxe.screen.h/2)
        });


        level_texture.filter_min = level_texture.filter_mag = phoenix.Texture.FilterType.nearest;
        level_sprite.scale = new Vector(Luxe.screen.w/240,Luxe.screen.h/160);

            //We will create 3 sprites, each with a different group
        var a_third = Luxe.screen.w/4;
        var half_a_third = (Luxe.screen.w/3)/2;
        var mid = Luxe.screen.h/2;

        luxe_sprite1 = new Sprite({
            texture : luxe_texture,
            pos : new Vector( a_third * 1, mid ),
            size : new Vector( half_a_third, half_a_third ),
            batcher: batch1
        });

        luxe_sprite2 = new Sprite({
            texture : luxe_texture,
            pos : new Vector( a_third * 2, mid ),
            size : new Vector( half_a_third, half_a_third ),
            batcher: batch2
        });

        luxe_sprite3 = new Sprite({
            texture : luxe_texture,
            pos : new Vector( a_third * 3, mid ),
            size : new Vector( half_a_third, half_a_third ),
            batcher: batch3
        });

            //for the first group, we set the blend mode to additive
        batch1.on(prerender, function(b:Batcher){ Luxe.renderer.blend_mode(BlendMode.src_alpha, BlendMode.one); });

            //for the second, we set it to negative
        batch2.on(prerender, function(b:Batcher){ Luxe.renderer.blend_mode(BlendMode.one_minus_src_color, BlendMode.zero); });

            //for the third one, we maks sure it is reset as well
        batch3.on(prerender, function(b:Batcher){ Luxe.renderer.blend_mode(BlendMode.dst_color, BlendMode.one_minus_src_alpha); });
        batch3.on(postrender, function(b:Batcher){ Luxe.renderer.blend_mode(); });

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup


} //Main
