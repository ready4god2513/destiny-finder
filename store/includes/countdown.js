
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
   <!-- 
   //enter limit in "minutes:seconds" Minutes should range from 0 to infinity. 
   //Seconds should range from 0 to 5 
  // 29:59 will run the timer for 30 minutes 
//   var limit = "29:59" 
   var limit = "29:59"  //(shorter time for testing) 
   if (document.images){ 
     var parselimit=limit.split(":") 
     parselimit=parselimit[0]*60+parselimit[1]*1 
   } 
   function begintimer(){ 
     if (!document.images) 
       return 
     if (window.name == "Help")  //Do not time out the help pages 
       return 
      parselimit = parselimit -1 
      curmin=Math.floor(parselimit/60) 
      cursec=parselimit%60 
         if (curmin == 5 && cursec == 59)
           {
               window.focus();
               curtime="Your session will expire in about " + "5 minutes"
               alert("Twenty-five (25) minutes have passed since the last save.  The application will timeout in five minutes. If no action is taken, your session will expire.");
          }                    
        else if (curmin > 0) 
          curtime="Your session will expire in about " + Number(curmin) + " minutes" 
        else if (curmin == 0)
               {
          curtime="Your session is about to expire." 
                 if (cursec == 0)
               <cfoutput>location.href = '#Path#index.cfm?UsrSelect=login'</cfoutput>
            }
      window.status=curtime 
      setTimeout("begintimer()",1000) 
   } 

//-->
</SCRIPT>
