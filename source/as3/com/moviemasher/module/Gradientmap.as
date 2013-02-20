﻿/** This Source Code Form is subject to the terms of the Mozilla Public* License, v. 2.0. If a copy of the MPL was not distributed with this* file, You can obtain one at http://mozilla.org/MPL/2.0/.* * Software distributed under the License is distributed on an* "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express* or implied. See the License for the specific language* governing rights and limitations under the License.* * The Original Code is 'Movie Masher'. The Initial Developer* of the Original Code is Doug Anarino. Portions created by* Doug Anarino are Copyright (C) 2007-2012 Movie Masher, Inc.* All Rights Reserved.*/package com.moviemasher.module{	import flash.geom.*;	import flash.display.*;	import com.moviemasher.utils.*;	import com.moviemasher.type.*;	import com.moviemasher.constant.*;/*** Implementation class for gradient map image module** @see IModule* @see Clip* @see Mash*/	public class Gradientmap extends Module	{		public function Gradientmap()		{			_defaults.map = 'rain';			_defaults.instances = '100';			_defaults.stickiness = '10';			_defaults.forecolor = 'FFFFFF';			_defaults.backcolor = '';			_defaults.size = '5';			_defaults.alpha = '100';			_defaults.alphas = '0,0,10,100,100,0';			_defaults.alphasfade = '0,0,90,100,100,0';			_defaults.fade = Fades.IN;			__canvas = new Shape();			addChild(__canvas);		}		override public function get backColor():String		{			return _getClipProperty(ModuleProperty.BACKCOLOR);		}		override public function set time(object:Time):void		{			super.time = object;			var done:Number = _getFade() / 100.0;			var map:String = _getClipProperty('map');			try			{				if (typeof(this['__' + map + 'Map']) == 'function')				{					__canvas.graphics.clear();					this['__' + map + 'Map'](done);				}			}			catch(e:*)			{				RunClass.MovieMasher['msg'](this, e);			}		}		override public function get displayObject():DisplayObjectContainer		{			return this;		}		private function __createDrops(size:Number, instances:Number):void		{			try			{								__drops = new Array();								var drop:Object;				var w:Number = _size.width - size;				var h:Number = _size.height - size;								var half_size:Number = size / 2;				for (var i:Number = 0; i < instances; i++)				{					drop = new Object();					drop.random = Math.random();					drop.x = (w * Math.random()) + half_size;					drop.y = (h * Math.random()) + half_size;					__drops.push(drop);				}			}			catch(e:*)			{				RunClass.MovieMasher['msg'](this + '.__createDrops ' + _size, e);			}					}		private function __drawCircleGrad(bmwidth:Number, bmheight:Number, xpos:Number, ypos:Number, done:Number, offset:Boolean = false):void		{			try			{				var forecolor:Number = RunClass.DrawUtility['colorFromHex'](_getClipProperty('forecolor'));				var base_colors:Array = [forecolor, forecolor, forecolor];				var a:Number = _getClipPropertyNumber('alpha');				var base_alphas:Array = [0, a / 100, 0];				var colors:Array = [];				var alphas:Array = [];				var scaled:Number = 10;				var z = Math.max(2, scaled - Math.floor(scaled * done));				for (var i = 0; i < z; i++)				{					colors = colors.concat(base_colors);					alphas = alphas.concat(base_alphas);				}				var offset_x:Number = 0;				var offset_y:Number = 0;								offset_x = - Math.round(_size.width / 2);				offset_y = - Math.round(_size.height / 2);							if (offset)				{					offset_x -= bmwidth / 2;					offset_y -= bmheight / 2;				}				var c:Object = new Object();				c.type = 'radial';				c.x = xpos + offset_x;				c.y = ypos + offset_y;				c.width = bmwidth;				c.height = bmheight;				c.colors = colors;				c.alphas = alphas;								RunClass.DrawUtility['fillBoxGrad'](__canvas.graphics, xpos + offset_x, ypos + offset_y, bmwidth, bmheight, c, a, 0, true);			}			catch(e:*)			{				RunClass.MovieMasher['msg'](this + '.__drawCircleGrad', e);			}		}		private function __fisheyeMap(done:Number):void		{			var forecolor:Number = RunClass.DrawUtility['colorFromHex'](_getClipProperty('forecolor'));			var colors:Array = [forecolor, forecolor];			var alphas:Array = [done, 0];			var offset_x:Number = - Math.round(_size.width / 2);			var offset_y:Number = - Math.round(_size.height / 2);					var c:Object = new Object();			c.type = 'radial';			c.x = offset_x;			c.y = offset_y;			c.width = _size.width;			c.height = _size.height;			c.colors = colors;			c.alphas = alphas;			RunClass.DrawUtility['fillBoxGrad'](__canvas.graphics, offset_x, offset_y, _size.width, _size.height, c);		}		override protected function _changedSize():void		{			super._changedSize();			__drops = null;		}				private function __rainMap(done:Number):void		{			try			{					var instances:Number = _getClipPropertyNumber('instances');				var size:Number = _getClipPropertyNumber('size');								// size is a percentage of height (like textsize)				size = (size * _size.height) / 100.0;								if (__drops == null) __createDrops(size, instances);				var forecolor:Number = RunClass.DrawUtility['colorFromHex'](_getClipProperty('forecolor'));				var stickiness:Number = _getClipPropertyNumber('stickiness') / 100;				var drop:Object;				var drop_done:Number;				for (var i:Number = 0; i < instances; i++)				{					drop = __drops[i];					if ((done >= (drop.random - stickiness)) && (done <= (drop.random + stickiness)))					{						drop_done = (done - (drop.random - stickiness)) / stickiness;						__drawCircleGrad(size * drop_done, size * drop_done, drop.x, drop.y, drop_done, true);					}				}				__canvas.graphics.endFill();				}			catch(e:*)			{				RunClass.MovieMasher['msg'](this + '.__rainMap ' + done, e);			}		}		private function __rippleMap(done:Number):void		{			__drawCircleGrad(_size.width, _size.height, 0, 0, done);			__canvas.graphics.endFill();		}		private function __gradMap(done:Number):void		{			var alphas_string:String = _getClipProperty('alphas');			if (alphas_string.length)			{				var alphasfade_string:String = _getClipProperty('alphasfade');				var forecolor:Number = RunClass.DrawUtility['colorFromHex'](_getClipProperty('forecolor'));				var colors:Array = new Array();				var z:uint;				var i:uint;				var alphas:Array = RunClass.PlotUtility['string2Plot'](alphas_string);				var grad:Array = new Array();				var ratios:Array = new Array();				if (alphasfade_string.length)				{					var times:Array = new Array();									var alphasfade:Array = RunClass.PlotUtility['string2Plot'](alphasfade_string);										var per:Number;					z = alphas.length / 2;					for (i = 0; i < z; i++)					{						per = alphas[i * 2];						if (times.indexOf(per) == -1)						{							times.push(per);						}					}					z = alphasfade.length / 2;					for (i = 0; i < z; i++)					{						per = alphasfade[i * 2];						if (times.indexOf(per) == -1)						{							times.push(per);						}					}										times.sort(Array.NUMERIC);					//RunClass.MovieMasher['msg'](this + '.__gradMap times = ' + times);					z = times.length;					for (i = 0; i < z; i++)					{												per = times[i];						ratios.push((per * 255.0) / 100.0);						grad.push(RunClass.PlotUtility['perValue'](done * 100.0, RunClass.PlotUtility['value'](alphasfade, per), RunClass.PlotUtility['value'](alphas, per)) / 100.0);					}				}				else				{					z = alphas.length / 2;					for (i = 0; i < z; i++)					{						per = alphas[i * 2];						ratios.push((per * 255.0) / 100.0);						per = alphas[i * 2 + 1];						grad.push(per / 100.00);					}				}				z = grad.length;				for (i = 0; i < z; i++)				{					colors.push(forecolor);				}				var offset_x:Number = - Math.round(_size.width / 2);				var offset_y:Number = - Math.round(_size.height / 2);							var c:Object = new Object();				c.type = 'linear';				c.x = offset_x;				c.y = offset_y;				c.width = _size.width;				c.height = _size.height;				c.colors = colors;				c.alphas = grad;				c.ratios = ratios;				//RunClass.MovieMasher['msg'](this + '.__gradMap ' + grad + ' ' + ratios);				RunClass.DrawUtility['fillBoxGrad'](__canvas.graphics, offset_x, offset_y, _size.width, _size.height, c);			}		}				private var __drops:Array;		private var __canvas:Shape;	}}