package ld33.mesh;

import h3d.scene.Mesh;
import h3d.Vector;

/**
 * ...
 * @author Namide (Damien Doussaud)
 */
class BulletMesh extends Mesh
{
	public var target : Vector;

	public function new(prim, ?mat, ?parent) 
	{
		super(prim, ?mat, ?parent);
		target = new Vector(0, 0, 0);
		
	}
	
	public function update() {
		if( follow != null ) {
			pos.set(0, 0, 0);
			target.set(0, 0, 0);
			follow.pos.localToGlobal(pos);
			follow.target.localToGlobal(target);
			// Animate FOV
			if( follow.pos.name != null ) {
				var p = follow.pos;
				while( p != null ) {
					if( p.currentAnimation != null ) {
						var v = p.currentAnimation.getPropValue(follow.pos.name, "FOVY");
						if( v != null ) {
							fovY = v;
							break;
						}
					}
					p = p.parent;
				}
			}
		}
		makeCameraMatrix(mcam);
		makeFrustumMatrix(mproj);
		m.multiply(mcam, mproj);
		needInv = true;
	}
	
}