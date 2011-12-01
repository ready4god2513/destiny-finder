
//calls a cfm page to refresh the user session every 15 minutes
	function keepAlive() {
    	var imgAlive = new Image();
    	var d = new Date();
    	imgAlive.src = 'image.cfm?refresh=1&d=' + d;
	}
	setInterval('keepAlive()', 15*60*1000);

