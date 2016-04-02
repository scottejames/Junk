<html>
<head>
<!--
This file retrieved from the JS-Examples archives
http://www.js-examples.com
100s of free ready to use scripts, tutorials, forums.
Author: JS-Examples - http://www.js-examples.com/ 
-->

<!--
  -- Copyright Notice:
  --
  -- Object Peeker  --  This notice must be left untouched at all times.
  --  Copyright www.JS-X.com 2000-current . All rights reserved.
  --
  --  Last modified 2002-02-12.
  --
  --  This script is published under an open source license.
  --
  --  THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
  --  IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
  --  WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  --
  --  This script was originally created for personal use. By request it has
  --  later been made public. This is free software. Do not try to sell this as your
  --  own work, or remove this copyright notice.
  --
  --  If you have an improvement to this script, please submit the changes
  --  to http://www.js-x.com/contact/ so that the script can be further improved.
  --  Additional improvements will have credit given appropertly.
  --
  -->

<!--
  --
  -- Notes:
  --   This script works only with IE (tested with IE6)
  --
  --   document.all.objectname is an IE only thing
  --   NS6 is DOM compatible (so is IE6): document.getElementById('objectname')
  --   NS4: document.objectname
  --
  -- This script will allow you to change the background image of a style ID
  -- by changing the style id.  It also allows you to observe the objects inside
  -- another object.  This can be useful in determining what objects are available
  -- to be set.
  --
  -->
<style>
body  { margin:0;}
#t0   { background: url("http://www.js-x.com/js/pic1.gif"); color: #FF0000;}
#t1   { background: url("http://www.js-x.com/js/pic2.gif"); color: #0000FF;}
#t2   { background: url("http://www.js-x.com/js/pic3.gif"); color: #FFFF00;}
#t3   { background: url("http://www.js-x.com/js/pic4.gif"); color: #00FFFF;}
</style>


</head>
<body>

<table height=100% width=100% border=0 cellpadding=0 cellspacing=0>
<tr><td id=t0><a href="javascript:showInfo('document.all.t0')">show object information for t0</a> |
<a onmouseover="changeImage()">mouse over this to change the image</a></td></tr></table>
<script>
var isIE=document.all?true:false; /* detect IE web browser */

var LAST=0; /* keeps track of last image id (style id) shown t0 or t1 */
/*
 * Function will toggle the image by changing the id name
 */
function changeImage()
{
  if(!isIE)return; /* only do this for IE as it is syntax'ed to only work for IE */
  var _LAST=LAST; /* remember so we know what object to change */
  LAST=(LAST+1)%4; /* increment mod the number of elements - 4 in this case 0,1,2,3 */
  eval("document.all.t"+_LAST+".id='t"+LAST+"';"); /* set the id name */
}


var _win=null;
function showInfo(_obj)
{
  var _HTML_START="<html><head><style>.s1{color:blue;}.s2{color:red;}.s3{color=green;}</style></head><body onunload='opener._win=null;' onload='self.focus()'><a href='javascript:self.close()'>close window</a><BR><BR>";
  var _HTML_END="</body></html>";
  var OBJ=eval(_obj);
  var I_set="Items Set:<BR><pre>";
  var I_notSet="Items Not Set:<BR><pre>";
  for(var item in OBJ)
  {
    var _value=eval("OBJ."+item);
	if(_value || parseInt(_value)==_value)
	{
	  var _regExp=/HTML/;
	  if(!_regExp.test(item))
        I_set+="<span class=s1>"+item+"</span><span class=s2>=</span><span class=s3>"+_value+"</span><BR>";
	  else
	    I_set+="<span class=s1>"+item+"</span><span class=s2>=</span><span class=s3><b><i>-Set But Code Not Shown-</i></b></span><BR>";
	}
	else
      I_notSet+="<span class=s1>"+item+"</span><BR>";
  }
  I_set+="</pre>";
  I_notSet+="</pre>";
  if(!_win)_win=window.open('','debug');
  _win.document.open();
  _win.document.write(_HTML_START+"OBJECT <span class=s1>"+_obj+"</span><BR><BR>"+I_set+"<BR><BR><HR><BR><BR>"+I_notSet+_HTML_END);
  _win.document.close();
}
</script>


</body>
</html>

