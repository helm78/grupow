package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.materials.BitmapAssetMaterial;
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;
	import org.papervision3d.render.BasicRenderEngine;
	
	/**
	* ...
	* @author Wolfito
	*/
	public class Main extends Sprite
	{
		
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var viewport:Viewport3D;
		private var render_engine:BasicRenderEngine;
		private var my_plane:Plane;
		private var active_index:int = 0;
		
		public function Main() 
		{
			create3dEnviroment();
			buildPlane();
			setEvents();
			render3d();
		}
		
		private function create3dEnviroment():void
		{
			camera = new Camera3D();
			scene = new Scene3D();
			viewport = new Viewport3D(0, 0, true, true);
			addChild(viewport);
			render_engine = new BasicRenderEngine();
		}
		
		private function setEvents():void
		{
			//
			stage.addEventListener(MouseEvent.MOUSE_OVER, startRendering, false, 0, true);
			stage.addEventListener(Event.MOUSE_LEAVE, stopRendering, false, 0, true);
			//
			this.switchButton.addEventListener(MouseEvent.CLICK, switchTexture, false, 0, true);
		}
		
		private function startRendering(e:MouseEvent):void 
		{
			if (!this.hasEventListener(Event.ENTER_FRAME))
			{
				this.addEventListener(Event.ENTER_FRAME, render, false, 0, true);
			}
		}
		
		private function stopRendering(e:Event):void 
		{
			this.removeEventListener(Event.ENTER_FRAME, render);
		}
		
		private function buildPlane():void
		{
			var texture:BitmapAssetMaterial = new BitmapAssetMaterial("Pocoyo_0");
			texture.smooth = true;
			my_plane = new Plane(texture, 500, 500, 4, 4);
			scene.addChild(my_plane);
			camera.target = my_plane;
		}
		
		private function render(e:Event):void
		{
			render3d();
			moveCamera();
		}
		
		private function render3d():void
		{
			render_engine.renderScene(scene, camera, viewport);
		}
		
		private function moveCamera():void
		{
			camera.x = (this.stage.mouseX - (this.stage.stageWidth / 2)) * 2;
			camera.y = (this.stage.mouseY - (this.stage.stageHeight / 2)) * 2;
		}
		
		private function switchTexture(e:MouseEvent):void
		{
			var bitmapData:BitmapData;
			if (active_index == 0)
			{
				bitmapData = new Pocoyo_1(283, 283);
				active_index = 1;
			}
			else
			{
				bitmapData = new Pocoyo_0(283, 283);
				active_index = 0;
			}
			my_plane.material.bitmap.dispose();
			my_plane.material.bitmap = bitmapData;
			my_plane.material.updateBitmap();
		}
	}
	
}