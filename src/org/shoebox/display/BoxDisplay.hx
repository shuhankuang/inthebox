package org.shoebox.display;

import nme.display.Stage;
import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;

/**
 * ...
 * @author shoe[box]
 */

class BoxDisplay{

	// -------o constructor
		
		/**
		* constructor
		*
		* @param	
		* @return	void
		*/
		public function new() {
			
		}
	
	// -------o public
				
		/**
		* 
		* 
		* @public
		* @return	void
		*/
		static public function haxeStage( d : DisplayObject ) : nme.display.Stage {
			return nme.Lib.current.stage;		
		}

		/**
		* 
		* 
		* @public
		* @return	void
		*/
		static public function purge( d : DisplayObjectContainer ) : Array<Dynamic> {
			var a = [ ];
			while( d.numChildren > 0 ){
				var child = d.getChildAt( 0 );
				a.push( d );
				d.removeChild( child );
			}

			return a;
		}

	// -------o protected
	
		

	// -------o misc
	
}