
import luxe.Vector;
import luxe.Input;
import luxe.Entity;
import luxe.Component;


import luxe.Color;

class FakeRigidBody extends Component {


    public function init() {
        trace('init rigidbody');
    } //init

    public function reset() {
        trace('reset rigidbody');
        trace('getting collider' + entity.get('collider'));
    } //reset

    public function destroyed() {
        trace('destroy rigidbody');
    } //destroyed


} //FakeRigidBody


class FakeMeshComponent extends Component {


    public function init() {
        trace('init FakeMeshComponent');
    } //init

    public function reset() {
        trace('reset FakeMeshComponent');
    } //reset

    public function destroyed() {
        trace('destroy FakeMeshComponent');
    } //destroyed


} //FakeMeshComponent

class FakeCollider extends Component {


    public function init() {
        trace('init FakeCollider');
    } //init

    public function reset() {
        trace('reset FakeCollider');
    } //reset

    public function destroyed() {
        trace('destroy FakeCollider');
    } //destroy


} //FakeCollider

class Main extends luxe.Game {


    var root : Entity;
    var child : Entity;
    var child_of_child : Entity;

    var spherething : Entity;
    var spherechild : Entity;

    var od : Bool = true;


    override function ready() {

        root = new Entity();
        root.pos = new Vector(10,10,10);

        child = new Entity();
        child_of_child = new Entity();

        child_of_child.parent = child;
        child.parent = root;

        child.pos = new Vector(10,10,10);
        child_of_child.pos = new Vector(50,0,10);

        spherething = new Entity();
        spherething.name = 'sphere';
        spherechild = new Entity();
        spherechild.name = 'childmesh';

        spherechild.parent = spherething;

            //physics on the parent
        spherething.add( FakeRigidBody, 'rigidbody');
        spherething.add( FakeCollider, 'collider');

            //add the mesh to the child
        spherechild.add( FakeMeshComponent, 'mesh');

            //test that get works, it should print the type names of all
        trace( spherething.get('collider') );
        trace( spherething.get('mesh', true) );
        trace( spherething.get('mesh') );
        trace( spherething.get('rigidbody') );

            //test
        spherething._init();
        spherething._reset();
        spherething.destroy();

    } //ready

    function draw_entities_transforms() {

        Luxe.draw.rectangle({
            x : root.pos.x - 2, y : root.pos.y - 2,
            w : 4, h : 4,
            color : new Color(0.2,0.6,1),
            immediate : true
        });

        Luxe.draw.rectangle({
            x : child.transform.world.pos.x - 2, y : child.transform.world.pos.y - 2,
            w : 4, h : 4,
            color : new Color(1,0.6,0.2),
            immediate : true
        });

        Luxe.draw.rectangle({
            x : child_of_child.transform.world.pos.x - 2, y : child_of_child.transform.world.pos.y - 2,
            w : 4, h : 4,
            color : new Color(0.6,1,0.2),
            immediate : true
        });

    } //draw_entities_transforms

    override function onmousemove( e:MouseEvent ) {

        if(od) {
            root.pos = new Vector(e.x,e.y);
        } else {
            child.pos = new Vector(e.x , e.y);
        }

    } //onmousemove

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.key_r) {

            child.pos = new Vector(10,10,10);
            child_of_child.pos = new Vector(50,0,10);

        } //R key

        if(e.keycode == Key.key_p) {

            if(child.parent != null) {
                child.parent = null;
                trace('no parent');
            } else {
                child.parent = root;
                trace('parent');
            }

            trace('absolute: ' + child.transform.world.pos);
            trace('relative: ' + child.pos);

        } //key_P

        if(e.keycode == Key.space) {
            od = !od;
        } //space

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        } //escape

    } //onkeyup

    override function update(dt:Float) {
        draw_entities_transforms();
    } //update



} //Main
