/**
  HomeMade by shoe[box]
  IN THE BOX PACKAGE (http://code.google.com/p/inthebox/)
   
  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of shoe[box] nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
package org.shoebox.display.containers;

	import nme.display.DisplayObject;
	import nme.display.BitmapData;
	import nme.display.Bitmap;
	import nme.display.IBitmapDrawable;
	import nme.display.Sprite;
	import nme.filters.BitmapFilter;
	import nme.geom.Matrix;
	import nme.geom.Point;
	import nme.geom.Rectangle;
	import nme.Lib;
	
	import org.shoebox.core.Vector2D;
	
	/**
	* ParallaxLayer
	* @author shoebox
	*/
	class ParallaxLayer extends Bitmap{
		
		public var bLoop				: Bool;
		public var position			: Vector2D;
		
		private var _bmpPattern		: BitmapData;
		private var _fDx				: Float;
		private var _fDy				: Float;
		private var _fRefWidth			: Float;
		private var _fRefHeight		: Float;
		private var _fSpeed			: Float;
		
		// -------o constructor
		
			/**
			* Constructor of the ParallaxLayer class
			*
			* @public
			* @return	void
			*/
			public function new( 
												bRef		: BitmapData,
												fSpeed	 	: Float = 1.0, 
												bLoop		: Bool 	= true												
											) : Void {
				super( );
				this.bLoop = bLoop;
				
				_fSpeed		= fSpeed;
				_fRefWidth 	= bRef.width;
				_fRefHeight = bRef.height;
				
				if( bLoop ){
					bitmapData = _updatePattern( bRef );
					bRef.dispose( );
				}else
					bitmapData = bRef;
			}

		// -------o public
			
			
			public function setTransform( dx : Int = 0 , dy : Int = 0 , fScaleX : Float = 1.0 , fScaleY : Float = 1.0 ) : Void{
			
				position = new Vector2D( dx , dy );
				_fDx = x = dx;
				_fDy = y = dy;
				scaleX = fScaleX;
				scaleY = fScaleY;
			}
			
			/**
			* dispose function
			* @public
			* @param 
			* @return
			*/
			public function dispose() : Void {
				
			}
			
			/**
			* translate function
			* @public
			* @param 
			* @return
			*/
			public function translate( dx : Float , dy : Float ) : Void{
				position.x += dx * _fSpeed;
				position.y += dy * _fSpeed;
				
				
				if( bLoop ){
					//trace( position.x+' - '+_fRefWidth+'  === '+_modulate( position.x , _fRefWidth ) );
					position.x = _modulate( position.x , _fRefWidth );
					position.y = _modulate( position.y , _fRefHeight );
				}
				
				
				x = position.x + _fDx;
				y = position.y + _fDy;
			}
			
		// -------o protected
			
			private function _updatePattern( bRef : BitmapData ) : BitmapData {
				
				var fWidth 	: Float = _fRefWidth;
				var fHeight	: Float = _fRefHeight;
				var iBlocW	: Int = 1;
				var iBlocH 	: Int = 1;
				if( _fRefWidth < Lib.current.stage.stageWidth ){
					
					iBlocW = Math.ceil( Lib.current.stage.stageWidth * 1.5 / _fRefWidth );
					fHeight = iBlocW * _fRefWidth;
				}
				
				
				var bRes 	: BitmapData = new BitmapData( Std.int( fWidth ) * iBlocW , Std.int( fHeight ) * iBlocH , true , 0xFF0000 );
				var ptDes	: Point = new Point( );
				
				for( dx in 0...iBlocW ){
					for( dy in 0...iBlocH ){
						ptDes.x = dx * fWidth;
						ptDes.y = dy * fHeight;
						
						bRes.copyPixels( bRef , bRef.rect , ptDes , null , null , true );
					}
				}
				
				return bRes;				
			}
			
			private function _modulate( fValue : Float , fModulo : Float ) : Float{
				
				#if iphone
					var b : Bool = false;
					var diff : Float = fValue - fModulo;
					if( diff < 0 )
						b = true;
					
					fValue = Math.abs(diff) % fModulo;
					if( b )
						fValue = -fValue;
					
					return fValue;
					
				#else
				return ( fValue - fModulo ) % fModulo;
				#end
			}
			
		// -------o misc

	}
