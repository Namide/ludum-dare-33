package ld33.shader;

import hxsl.Shader;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class BulletShader extends Shader
{

	static var SRC = {
		@input var input : {
			//var color : Vec3;
			var camera : Vec3;
			var uv: Vec2;
			var position : Vec3;
		};

		@global var camera : {
			var viewProj : Mat4;
			var position : Vec3;
		};
		
		var output : {
			position : Vec4,
			color : Vec4,
		};
		
		//var pixelColor : Vec4;
		//var projectedPosition : Vec4;
		//var depth : Float;

		//@const var additive : Bool;
		//@param var farDist : Float;
		//@param var bgColor : Vec3;
		
		//var color : Vec3;
		//var position : Vec4;
		function vertex() {
			//var dist = projectedPosition.z / farDist;
			//color = input.color * (1.0 - dist) + bgColor * dist;
			
			//output.position = vec4(input.position.xyz , 1);
			
			//position = input.position;
			
			//output.position = vec4(input.position, 1);
			
		}
		
		//function fragment() {
			//pixelColor.rgb = color.rgb;
			
		//}

	};
	
}