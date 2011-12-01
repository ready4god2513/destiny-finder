/* -----------------------------------------------------------------

	In this file:

	1. Define windows
	
		var myWindow = function(){ 
			new MochaUI.Window({
				id: 'mywindow',
				title: 'My Window',
				loadMethod: 'xhr',
				contentURL: 'pages/lipsum.html',
				width: 340,
				height: 150
			});
		}

	2. Build windows on onDomReady
	
		myWindow();
	
	3. Add link events to build future windows
	
		if ($('myWindowLink')){
			$('myWindowLink').addEvent('click', function(e) {
				new Event(e).stop();
				jsonWindows();
			});
		}

		Note: If your link is in the top menu, it opens only a single window, and you would
		like a check mark next to it when it's window is open, format the link name as follows:

		window.id + LinkCheck, e.g., mywindowLinkCheck

		Otherwise it is suggested you just use mywindowLink

	Associated HTML for link event above:

		<a id="myWindowLink" href="pages/lipsum.html">My Window</a>	


	Notes:
		If you need to add link events to links within windows you are creating, do
		it in the onContentLoaded function of the new window.


   ----------------------------------------------------------------- */

initializeWindows = function(){

	//Gateway Module
	MochaUI.gatewayWindow = function(){
		new MochaUI.Window({
			id: 'gateways',
			title: 'Gateway Listing',
			loadMethod: 'iframe',
			contentURL: 'gateway_listing.cfm',
			width: 600,
			height: 600,
			contentBgColor: '#ffffff'
		});
	}
	if ($('gatewayLinkCheck')) {
		$('gatewayLinkCheck').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.gatewayWindow();
		});
	}

	//Homepage Module
	MochaUI.homepageWindow = function(){
		new MochaUI.Window({
			id: 'homepage',
			title: 'Manage Misc Content',
			loadMethod: 'iframe',
			contentURL: 'manage_misc_content.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('manageHomeCheck')) {
		$('manageHomeCheck').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.homepageWindow();
		});
	}		
	
	//Homepage Matrix
	MochaUI.matrixWindow = function(){
		new MochaUI.Window({
			id: 'matrix',
			title: 'Manage Home Matrix',
			loadMethod: 'iframe',
			contentURL: 'home_matrix_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('manageMatrixCheck')) {
		$('manageMatrixCheck').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.matrixWindow();
		});
	}		
	
	//User Module
	MochaUI.userWindow = function(){
		new MochaUI.Window({
			id: 'user',
			title: 'Manage Users',
			loadMethod: 'iframe',
			contentURL: 'user_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('userCheck')) {
		$('userCheck').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.userWindow();
		});
	}		
	
	//Game Module
	MochaUI.gameWindow = function(){
		new MochaUI.Window({
			id: 'game',
			title: 'Manage Game',
			loadMethod: 'iframe',
			contentURL: 'game_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('manageGame')) {
		$('manageGame').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.gameWindow();
		});
	}		
	
	//Banner Module
	MochaUI.bannerWindow = function(){
		new MochaUI.Window({
			id: 'banner_ad',
			title: 'Manage Banner Ads',
			loadMethod: 'iframe',
			contentURL: 'banner_ad_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managebanners')) {
		$('managebanners').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.bannerWindow();
		});
	}		
		
	//Itinerary Module
	MochaUI.itineraryWindow = function(){
		new MochaUI.Window({
			id: 'itinerary',
			title: 'Manage Itinerary',
			loadMethod: 'iframe',
			contentURL: 'itinerary_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('manageitinerary')) {
		$('manageitinerary').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.itineraryWindow();
		});
	}		
	
	//Conference Module
	MochaUI.conferenceWindow = function(){
		new MochaUI.Window({
			id: 'conference',
			title: 'Manage Conference',
			loadMethod: 'iframe',
			contentURL: 'conference_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('manageconferences')) {
		$('manageconferences').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.conferenceWindow();
		});
	}		


	//Media Global Module
	MochaUI.mediaWindow = function(){
		new MochaUI.Window({
			id: 'globalmedia',
			title: 'Manage Media',
			loadMethod: 'iframe',
			contentURL: 'media_global.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managemedia')) {
		$('managemedia').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.mediaWindow();
		});
	}		
	
	

	//Media [Audio] Module
	MochaUI.mediaaudioWindow = function(){
		new MochaUI.Window({
			id: 'mediaaudio',
			title: 'Manage Audio Media',
			loadMethod: 'iframe',
			contentURL: 'media_listing.cfm?media_type=audio',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managemediaaudio')) {
		$('managemediaaudio').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.mediaaudioWindow();
		});
	}		
	
	//Media [Video] Module
	MochaUI.mediavideoWindow = function(){
		new MochaUI.Window({
			id: 'mediavideo',
			title: 'Manage Video Media',
			loadMethod: 'iframe',
			contentURL: 'media_listing.cfm?media_type=video',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managemediavideo')) {
		$('managemediavideo').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.mediavideoWindow();
		});
	}		
	
	//Gallery Module
	MochaUI.galleryWindow = function(){
		new MochaUI.Window({
			id: 'gallery',
			title: 'Manage Gallery',
			loadMethod: 'iframe',
			contentURL: 'photo_album_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managegallery')) {
		$('managegallery').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.galleryWindow();
		});
	}		
	
	//Rotating Module
	MochaUI.rotatingWindow = function(){
		new MochaUI.Window({
			id: 'rotating',
			title: 'Manage Rotating Images',
			loadMethod: 'iframe',
			contentURL: 'rotating_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managerotating')) {
		$('managerotating').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.rotatingWindow();
		});
	}		
	
	//Rotating Module
	MochaUI.testimonyWindow = function(){
		new MochaUI.Window({
			id: 'rotating',
			title: 'Manage Testimony',
			loadMethod: 'iframe',
			contentURL: 'testimony_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managetestimony')) {
		$('managetestimony').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.testimonyWindow();
		});
	}		
	
	//Articles Module
	MochaUI.articleWindow = function(){
		new MochaUI.Window({
			id: 'article',
			title: 'Manage Articles',
			loadMethod: 'iframe',
			contentURL: 'article_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managearticles')) {
		$('managearticles').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.articleWindow();
		});
	}		
	
	//Home Module
	MochaUI.homeWindow = function(){
		new MochaUI.Window({
			id: 'home',
			title: 'Manage Home',
			loadMethod: 'iframe',
			contentURL: 'manage_home_page.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('managehome')) {
		$('managehome').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.homeWindow();
		});
	}		
	
	//Events
	MochaUI.eventsWindow = function(){
		new MochaUI.Window({
			id: 'events_listing',
			title: 'Event Listing',
			loadMethod: 'iframe',
			contentURL: 'cal_event_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('events')) {
		$('events').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.eventsWindow();
		});
	}	
	
	//Event Categories
	MochaUI.eventcatWindow = function(){
		new MochaUI.Window({
			id: 'eventcatlisting',
			title: 'Event Category Listing',
			loadMethod: 'iframe',
			contentURL: 'event_category_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('eventcats')) {
		$('eventcats').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.eventcatWindow();
		});
	}	
	
	//Newsletter Report
	MochaUI.signupreportWindow = function(){
		new MochaUI.Window({
			id: 'signups',
			title: 'Newsletter Signups',
			loadMethod: 'iframe',
			contentURL: 'newsletter_csv.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('signupreport')) {
		$('signupreport').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.signupreportWindow();
		});
	}	
	
	//Accordion
	MochaUI.accordionWindow = function(){
		new MochaUI.Window({
			id: 'accordion_',
			title: 'Accordion',
			loadMethod: 'iframe',
			contentURL: 'accordion.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('accordion')) {
		$('accordion').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.accordionWindow();
		});
	}		
	
	///**** BLOG MODULES ***////
//Author Admin
	MochaUI.authorWindow = function(){
		new MochaUI.Window({
			id: 'authorlist',
			title: 'Authors',
			loadMethod: 'iframe',
			contentURL: 'site_user_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('author')) {
		$('author').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.authorWindow();
		});
	}		
	
	//Comments Admin
	MochaUI.commentWindow = function(){
		new MochaUI.Window({
			id: 'commentlist',
			title: 'Comment',
			loadMethod: 'iframe',
			contentURL: 'comments_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('comment')) {
		$('comment').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.commentWindow();
		});
	}		
	
	//Blog/Post Admin
	MochaUI.postWindow = function(){
		new MochaUI.Window({
			id: 'postlist',
			title: 'Posts',
			loadMethod: 'iframe',
			contentURL: 'post_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('posts')) {
		$('posts').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.postWindow();
		});
	}		
	
	//Temp Blog/Post Admin
	MochaUI.posttempWindow = function(){
		new MochaUI.Window({
			id: 'temppostlist',
			title: 'Post Updates',
			loadMethod: 'iframe',
			contentURL: 'blog_temp_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('posttemp')) {
		$('posttemp').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.posttempWindow();
		});
	}		
	
	
	//Blog/Post Categories
	MochaUI.categoryWindow = function(){
		new MochaUI.Window({
			id: 'categorylist',
			title: 'Categories',
			loadMethod: 'iframe',
			contentURL: 'post_category_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('post_categories')) {
		$('post_categories').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.categoryWindow();
		});
	}		
	
	
	//Blog Home Page
	MochaUI.blogWindow = function(){
		new MochaUI.Window({
			id: 'blog_',
			title: 'Blog',
			loadMethod: 'iframe',
			contentURL: 'blog_home.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('blog_home')) {
		$('blog_home').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.blogWindow();
		});
	}		
	///**** END BLOG MODULES ***////
	
	//Gift Listing
	MochaUI.giftWindow = function(){
		new MochaUI.Window({
			id: 'gift_',
			title: 'Gift Type',
			loadMethod: 'iframe',
			contentURL: 'gift_type_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('gift')) {
		$('gift').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.giftWindow();
		});
	}		
	
	//Assessment Listing
	MochaUI.assessmentWindow = function(){
		new MochaUI.Window({
			id: 'assessment_',
			title: 'Assessments',
			loadMethod: 'iframe',
			contentURL: 'assessment_listing.cfm',
			width: 600,
			height: 475,
			contentBgColor: '#ffffff'
		});
	}
	if ($('assessment')) {
		$('assessment').addEvent('click', function(e){
		new Event(e).stop();
			MochaUI.assessmentWindow();
		});
	}		
	
	
}

// Initialize MochaUI when the DOM is ready
window.addEvent('domready', function(){
	MochaUI.Desktop = new MochaUI.Desktop();
	MochaUI.Dock = new MochaUI.Dock();

	/* Create Columns
	 
	If you are not using panels then these columns are not required.
	If you do use panels, the main column is required. The side columns are optional.
	Create your columns from left to right. Then create your panels from top to bottom,
	left to right. New Panels are inserted at the bottom of their column.

	*/	 

	new MochaUI.Column({
		id: 'mainColumn',
		placement: 'main',	
		width: null,
		resizeLimit: [100, 300]
	});
	

	// Add panels to main column	
	new MochaUI.Panel({
		id: 'mainPanel',
		title: 'Site View',
		loadMethod: 'iframe',
		contentURL: '/index2.cfm',
		column: 'mainColumn',
		panelBackground: '#fff'
	});



	MochaUI.Modal = new MochaUI.Modal();
	
	MochaUI.Desktop.desktop.setStyles({
		'background': '#fff',
		'visibility': 'visible'
	});
	initializeWindows();

});

// This runs when a person leaves your page.
window.addEvent('unload', function(){
	if (MochaUI) MochaUI.garbageCleanUp();
});



function Reload () {
var f = document.getElementById('mainPanel_iframe');
f.contentWindow.location.reload(true);
}
