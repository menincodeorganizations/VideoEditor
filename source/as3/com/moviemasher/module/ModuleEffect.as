﻿/*
* This Source Code Form is subject to the terms of the Mozilla Public
* License, v. 2.0. If a copy of the MPL was not distributed with this
* file, You can obtain one at http://mozilla.org/MPL/2.0/.
* 
* Software distributed under the License is distributed on an
* "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express
* or implied. See the License for the specific language
* governing rights and limitations under the License.
* 
* The Original Code is 'Movie Masher'. The Initial Developer
* of the Original Code is Doug Anarino. Portions created by
* Doug Anarino are Copyright (C) 2007-2012 Movie Masher, Inc.
* All Rights Reserved.
*/
package com.moviemasher.module
{
	import com.moviemasher.events.*;
	import com.moviemasher.interfaces.*;
	import com.moviemasher.constant.*;
	import com.moviemasher.type.*;
	import com.moviemasher.constant.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
/**
* Abstract base class for all modules. 
*
* @see Clip
* @see Mash
*/
	public class ModuleEffect extends Module implements IModuleEffect
	{
		public function ModuleEffect()
		{
			
		}
		
		public function get moduleFilters():Array
		{
			return _moduleFilters;
		}
		public function get moduleColorTransform():ColorTransform
		{
			return _moduleColorTransform;
		}
		public function get moduleMatrix():Matrix
		{
			return _moduleMatrix;
		}
		protected var _moduleFilters:Array = null;
		protected var _moduleColorTransform:ColorTransform = null;
		protected var _moduleMatrix:Matrix = null;
		
		
	}
}