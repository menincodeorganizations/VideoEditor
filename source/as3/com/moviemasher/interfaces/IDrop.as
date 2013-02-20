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

package com.moviemasher.interfaces
{
	import flash.geom.*;
	import com.moviemasher.type.*;
	import com.moviemasher.constant.*;

/**
* Interface for drop targets
*
* @see DragUtility
* @see Browser
* @see Player
* @see Timeline
*/
	public interface IDrop
	{		
		function overPoint(pt:Point):Boolean;
		function dragAccept(drag:DragData):void;
		function dragOver(drag:DragData):Boolean;
		function dragHilite(tf:Boolean):void;
	}
}