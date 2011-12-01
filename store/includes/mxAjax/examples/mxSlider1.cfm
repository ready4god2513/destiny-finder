<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Populating Drop down list with Coldfusion Array</title>
		<script type='text/javascript' src='../core/js/prototype.js'></script>
		<script type='text/javascript' src='../core/js/scriptaculous.js'></script>
		<script type='text/javascript' src='../core/js/slider.js'></script>
		<script type='text/javascript' src='../core/js/mxAjax.js'></script>

		<link rel="stylesheet" type="text/css" href="style.css"/>
	</head>
	<body>
		
		
		<h1>Slider control</h1>
		<table>
			<tr>
				<td valign="top">
					<p><strong>Horizontal slider</strong> 
					<div id="track1" style="width:224px;height:10px;background-color:#aaa;background:url(../core/images/sliderBar.gif) center no-repeat;">
					    <div id="handle1" style="cursor:default;width:22px;height:11px;background:url(../core/images/sliderThumb.gif) 100% no-repeat;"> </div>
					</div>
					<div id="debug1" style="padding-top: 5px;"></div></p>
					<br/>
					
					<div id="track10" style="width:224px;height:14px;background-color:#aaa;background:url(../core/images/sliderbgwticks.gif) center no-repeat;">
					    <div id="handle10" style="cursor:move;width:12px;height:19px;background:url(../core/images/sliderthumb2.gif) 100% no-repeat;"> </div>
					</div>
					<div id="debug10" style="padding-top: 5px;"></div></p>
					<br/>
					
					<div id="track11" style="width:105px;height:24px;background-color:#aaa;background:url(../core/images/sldr4h_bg.gif) center no-repeat;">
					    <div id="handle11" style="top:10px;cursor:default;width:13px;height:13px;background:url(../core/images/sldr4h_sl.gif) 100% no-repeat;"> </div>
					</div>
					<div id="debug11" style="padding-top: 5px;"></div></p>
					<br/>
				</td>
				<td width="100"></td>
				<td>
					<p><strong>Vertical slider</strong>
					<table>
						<tr>
							<td width="250" valign="top">
								<div id="track2" style="height:100px;background-color:#aaa;width:5px;">
									<div id="handle2" style="width:10px;height:5px;background-color:#f00;cursor:move;"> </div>
								</div>
								<div id="debug2"></div></p>
							</td>
							<td width="250" valign="top">
								<div id="track20" style="height:149px;width:17px;background-color:#aaa;background:url(../core/images/sldr5v_bg.gif) center no-repeat;">
									<div id="handle20" style="width:17px;height:9px;cursor:move;background:url(../core/images/sldr5v_sl.gif) 100% no-repeat;"> </div>
								</div>
								<div id="debug20"></div></p>
							</td>
						</tr>
						<tr>
							<td valign="top">
								<div id="track21" style="height:140px;width:16px;background-color:#aaa;background:url(../core/images/sldr1h_bg.gif) center no-repeat;">
									<div id="handle21" style="width:16px;height:17px;cursor:default;background:url(../core/images/sldr3v_sl.gif) 100% no-repeat;"> </div>
								</div>
								<div id="debug21"></div></p>
							</td>
							<td valign="top">
								<br/>
								<div id="track22" style="height:100px;width:16px;background-color:#aaa;background:url(../core/images/sldr3v_bg.gif) center no-repeat;">
									<div id="handle22" style="width:16px;height:19px;cursor:move;background:url(../core/images/sldr1h_sl.gif) 100% no-repeat;"> </div>
								</div>
								<div id="debug22"></div></p>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<script type="text/javascript" language="javascript">
		    new Control.Slider('handle1','track1',{
		      onSlide:function(v){$('debug1').innerHTML='slide: '+v},
		      onChange:function(v){$('debug1').innerHTML='changed! '+v}});
		
		    new Control.Slider('handle10','track10',{range:$R(1,15),
		        values:[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],
		      onSlide:function(v){$('debug10').innerHTML='slide: '+v},
		      onChange:function(v){$('debug10').innerHTML='changed! '+v}});
		
		    new Control.Slider('handle11','track11',{range:$R(1,8),
		    	values:[1,2,3,4,5,6,7,8],
		      onSlide:function(v){$('debug11').innerHTML='slide: '+v},
		      onChange:function(v){$('debug11').innerHTML='changed! '+v}});
		
		
		    new Control.Slider('handle2','track2',{axis:'vertical',
		        onSlide:function(v){$('debug2').innerHTML='slide: '+v},
		        onChange:function(v){$('debug2').innerHTML='changed! '+v}});
		        
		    new Control.Slider('handle20','track20',{axis:'vertical',
		        onSlide:function(v){$('debug20').innerHTML='slide: '+v},
		        onChange:function(v){$('debug20').innerHTML='changed! '+v}});
		
		    new Control.Slider('handle21','track21',{axis:'vertical',
		        onSlide:function(v){$('debug21').innerHTML='slide: '+v},
		        onChange:function(v){$('debug21').innerHTML='changed! '+v}});
		        
		    new Control.Slider('handle22','track22',{axis:'vertical', range:$R(0,200), 
		        values:[0,1,50,100,150,200],
		        onSlide:function(v){$('debug22').innerHTML='slide: '+v},
		        onChange:function(v){$('debug22').innerHTML='changed! '+v}});
		</script>
		
		
	</body>
</html>