
<cfscript>
/**
 * Cleans string of potential sql injection.
 * 
 * @param string 	 String to modify. (Required)
 * @return Returns a string. 
 * @author Bryan Murphy (bryan@guardianlogic.com) 
 * @version 1, May 26, 2005 
 */
function SQLSafe(string) {
  var sqlList = "-- ,'";
  var replacementList = "#chr(38)##chr(35)##chr(52)##chr(53)##chr(59)##chr(38)##chr(35)##chr(52)##chr(53)##chr(59)# , #chr(38)##chr(35)##chr(51)##chr(57)##chr(59)#";
  
  return trim(replaceList( string , sqlList , replacementList ));
}
</cfscript>

