<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.plays.model.Alien"%>
<%@page import="com.plays.model.WiFiMap"%>
<%@page import="com.plays.model.Area"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.plays.services.AlienServicesLocal"%>

<html>
<head>
    <title>NJIT WiFi Map</title>
    <style>
		table,th,td
		{
		border:1px solid black;
		border-collapse:collapse;
		}
		th,td
		{
		padding:5px;
		}
		th
		{
		text-align:left;
		}
		
		.header img {
		  float: left;
		  width: 150px;
		  height: 50px;
		  background: #555;
		}
		
		.header h1 {
		  position: relative;
		  top: 18px;
		  left: 10px;
		}
	</style>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
    <script>
/** @constructor */
function CoordMapType(tileSize) {
  this.tileSize = tileSize;
}

CoordMapType.prototype.getTile = function(coord, zoom, ownerDocument) {
  var div = ownerDocument.createElement('div');
  div.innerHTML = coord;
  div.style.width = this.tileSize.width + 'px';
  div.style.height = this.tileSize.height + 'px';
  div.style.fontSize = '10';
  div.style.borderStyle = 'solid';
  div.style.borderWidth = '1px';
  div.style.borderColor = '#AAAAAA';
  return div;
};

var map;
var aliens=[];
var tiles=[];
var myJsonTiles;
var chicago = new google.maps.LatLng(41.850033,-87.6500523);
var njit = new google.maps.LatLng(40.741675,-74.177552);
var njit1 = new google.maps.LatLng(40.744721,-74.179841);
var njit2 = new google.maps.LatLng(40.742689,-74.173361);
var njit3 = new google.maps.LatLng(40.738754,-74.175442);
var njit4 = new google.maps.LatLng(40.740819,-74.181815);
var TILE_SIZE = 256;

function bound(value, opt_min, opt_max) {
	  if (opt_min != null) value = Math.max(value, opt_min);
	  if (opt_max != null) value = Math.min(value, opt_max);
	  return value;
	}

	function degreesToRadians(deg) {
	  return deg * (Math.PI / 180);
	}

	function radiansToDegrees(rad) {
	  return rad / (Math.PI / 180);
	}

	/** @constructor */
	function MercatorProjection() {
	  this.pixelOrigin_ = new google.maps.Point(TILE_SIZE / 2,
	      TILE_SIZE / 2);
	  this.pixelsPerLonDegree_ = TILE_SIZE / 360;
	  this.pixelsPerLonRadian_ = TILE_SIZE / (2 * Math.PI);
	}

	MercatorProjection.prototype.fromLatLngToPoint = function(latLng,
	    opt_point) {
	  var me = this;
	  var point = opt_point || new google.maps.Point(0, 0);
	  var origin = me.pixelOrigin_;

	  point.x = origin.x + latLng.lng() * me.pixelsPerLonDegree_;

	  // Truncating to 0.9999 effectively limits latitude to 89.189. This is
	  // about a third of a tile past the edge of the world tile.
	  var siny = bound(Math.sin(degreesToRadians(latLng.lat())), -0.9999,
	      0.9999);
	  point.y = origin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) *
	      -me.pixelsPerLonRadian_;
	  return point;
	};

	MercatorProjection.prototype.fromPointToLatLng = function(point) {
	  var me = this;
	  var origin = me.pixelOrigin_;
	  var lng = (point.x - origin.x) / me.pixelsPerLonDegree_;
	  var latRadians = (point.y - origin.y) / -me.pixelsPerLonRadian_;
	  var lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) -
	      Math.PI / 2);
	  return new google.maps.LatLng(lat, lng);
	};

	
	function viewWiFiMap(map,bound) {
		var i = 0;
		aliens = [];
	  	<%
			List<WiFiMap> wiFiMapList = new ArrayList<WiFiMap>();	  		

  		InitialContext ic = new InitialContext();  
  		AlienServicesLocal alienServicesLocal=(AlienServicesLocal) ic.lookup("java:global/Plays/PlaysEJB/AlienServices!com.plays.services.AlienServicesLocal");
	  	wiFiMapList = alienServicesLocal.findMcsenseNJITCovSquares();
			for(WiFiMap wiFiMap : wiFiMapList){
				Area area = wiFiMap.getArea();
				double lat = 0.0;
				double lng = 0.0;
				if(area!=null){
					lat = area.getGpsLat();
					lng = area.getGpsLng();
				} 				
				int maxSignalLevel = wiFiMap.getMaxSignalLevel();
				if(lat != 0.0 && lng != 0.0) {
			%>				
					var loc = new google.maps.LatLng(<%= lat%>,<%= lng%>);
					//add circle
					var color = '#06DF31';
					var maxWifiSignal = <%= maxSignalLevel%>;
					if(maxWifiSignal >= -35)
						color = '#06DF31';//green
					else if(maxWifiSignal < -35 && maxWifiSignal >= -70)
						color = '#3EEFFC';//blue
					else if(maxWifiSignal < -70)
						color = '#F4FA3E';//yellow
					var sqCircle;
					 var sqOptions = {
				      //strokeColor: color,
				      strokeOpacity: 0,
				      strokeWeight: 0,
				      fillColor: color,
				      fillOpacity: 0.35,
				      map: map,
				      center: loc,
				      radius: 10
				    };
				    // Add the circle for this city to the map.
				    sqCircle = new google.maps.Circle(sqOptions);
					
			<%
				}
			}
		%>
	}
	
	function viewNoWiFiMap(map,bound) {
		var i = 0;
		aliens = [];
	  	<%
			List<WiFiMap> noWiFiMapList = new ArrayList<WiFiMap>();	  		
	  	 
	  	noWiFiMapList = alienServicesLocal.findNoNJITCovSquares();
			for(WiFiMap wiFiMap : noWiFiMapList){
				Area area = wiFiMap.getArea();
				double lat = 0.0;
				double lng = 0.0;
				if(area!=null){
					lat = area.getGpsLat();
					lng = area.getGpsLng();
				} 				
				if(lat != 0.0 && lng != 0.0) {
			%>				
					var loc = new google.maps.LatLng(<%= lat%>,<%= lng%>);
					//add circle
					var color = '#FE1212';//red
					var sqCircle;
					 var sqOptions = {
				      //strokeColor: color,
				      strokeOpacity: 0,
				      strokeWeight: 0,
				      fillColor: color,
				      fillOpacity: 0.35,
				      map: map,
				      center: loc,
				      radius: 10
				    };
				    // Add the circle for this city to the map.
				    sqCircle = new google.maps.Circle(sqOptions);
					
			<%
				}
			}
		%>
	}


	
function initialize() {
  var mapOptions = {
    zoom: 21,
    center: njit,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
                                    mapOptions);

  // Insert this overlay map type as the first overlay map type at
  // position 0. Note that all overlay map types appear on top of
  // their parent base map.
  map.overlayMapTypes.insertAt(
      0, new CoordMapType(new google.maps.Size(256, 256)));
  /*
  var coordInfoWindow = new google.maps.InfoWindow();
  coordInfoWindow.setContent(createInfoWindowContent());
  coordInfoWindow.setPosition(njit);
  coordInfoWindow.open(map);

  google.maps.event.addListener(map, 'zoom_changed', function() {
    coordInfoWindow.setContent(createInfoWindowContent());
    coordInfoWindow.open(map);
  });
  */
  //createPolygon(njit1,njit2,njit3,njit4,map);
  
  var bound = new google.maps.LatLngBounds(njit1,njit2,njit3,njit4);

  //viewAliens(map,bound);
  //viewAreas();
  viewWiFiMap(map,bound);
  //viewNoWiFiMap(map,bound);
  google.maps.event.addListener(map, 'zoom_changed', function() {
      if (map.getZoom() == 21) {
    	  //viewAliens(map,bound);
    	  //viewAreas(); 
    	  viewWiFiMap(map,bound);
    	  //viewNoWiFiMap(map,bound);
      }
      else {
          //hideMarkers();
      }
  });
  
  map.fitBounds(bound);
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
  <div class="header">
  <img src="../images/njit-logo.jpg" alt="logo" />
  <h1 align="center">NJIT WiFi Map</h1>
</div>
<br>
<p align="left">Campus is mapped with NJIT WiFi coverage as part of <a href="http://web.njit.edu/~mt57/mcsense/">McSense</a> project.
 <i> For more details on the project contact: mt57@njit.edu.</i>

<table style="width:975px">
<tr>
  <th bgcolor = '#06DF31'>GREEN areas with STRONG signal strength</th>
  <th bgcolor = '#3EEFFC'>BLUE areas with MEDIUM signal strength</th> 
  <th bgcolor = '#F4FA3E'>YELLOW areas with LOW signal strength</th>
</tr>

</table>
<br>
    <div id="map-canvas"></div>
  </body>
</html>