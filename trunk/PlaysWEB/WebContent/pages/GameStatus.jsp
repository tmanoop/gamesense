<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.plays.model.Alien"%>
<%@page import="com.plays.model.SensorReading"%>
<%@page import="com.plays.model.Sentinel"%>
<%@page import="com.plays.model.Area"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="com.plays.services.AlienServicesLocal"%>

<html>
<head>
    <title>Overlay map types</title>
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
var chicago = new google.maps.LatLng(41.850033,-87.6500523);
var njit = new google.maps.LatLng(40.744778,-74.179854);
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

	function createInfoWindowContent() {
	  var numTiles = 1 << map.getZoom();
	  var projection = new MercatorProjection();
	  var worldCoordinate = projection.fromLatLngToPoint(njit);
	  var pixelCoordinate = new google.maps.Point(
	      worldCoordinate.x * numTiles,
	      worldCoordinate.y * numTiles);
	  var tileCoordinate = new google.maps.Point(
	      Math.floor(pixelCoordinate.x / TILE_SIZE),
	      Math.floor(pixelCoordinate.y / TILE_SIZE));

	  return [
	    'NJIT, NJ',
	    'LatLng: ' + njit.lat() + ' , ' + njit.lng(),
	    'World Coordinate: ' + worldCoordinate.x + ' , ' +
	      worldCoordinate.y,
	    'Pixel Coordinate: ' + Math.floor(pixelCoordinate.x) + ' , ' +
	      Math.floor(pixelCoordinate.y),
	    'Tile Coordinate: ' + tileCoordinate.x + ' , ' +
	      tileCoordinate.y + ' at Zoom Level: ' + map.getZoom()
	  ].join('<br>');
	}

	function createPolygon(latlng1,latlng2,latlng3,latlng4,map) {
		var polygonNJIT;
		  
		//Define the LatLng coordinates for the polygon's path.
		  var njitCoords = [latlng1,latlng2,latlng3,latlng4,latlng1];

		  // Construct the polygon.
		  polygonNJIT = new google.maps.Polyline({
		    paths: njitCoords,
		    geodesic: true,
		    strokeColor: '#FF0000',
		    strokeOpacity: 1.0,
		    strokeWeight: 2
		  });

		  polygonNJIT.setMap(map);
	}

	function viewAliens(map,bound) {
		var i = 0;
		aliens = [];
	  	<%
			List<Alien> locList = new ArrayList<Alien>();	  		
	  		
	  		InitialContext ic = new InitialContext();  
	  		AlienServicesLocal alienServicesLocal=(AlienServicesLocal) ic.lookup("java:global/Plays/PlaysEJB/AlienServices!com.plays.services.AlienServicesLocal"); 
	  		locList = alienServicesLocal.allAliens();
			for(Alien al : locList){
				Area area = al.getArea();
				double lat = 0.0;
				double lng = 0.0;
				if(area!=null){
					lat = area.getGpsLat();
					lng = area.getGpsLng();
				} 				
				int alienID = al.getAlienId();
				if(lat != 0.0 && lng != 0.0 && al.getShotCount() < 2) {//&& area.getCoveredInd().equalsIgnoreCase("N")
			%>				
					var loc = new google.maps.LatLng(<%= lat%>,<%= lng%>);
					//http://google.com/mapfiles/kml/paddle/A.png
					//https://mcsense.googlecode.com/files/alien.png
					var iconBase = '../images/';
					var marker = new google.maps.Marker({
				       position: loc,
				       map: map,
				       icon: iconBase + 'alien.png'
				    });
				    marker.setTitle("Alien "+<%= alienID%>);
				    bound.extend(loc);
				    aliens.push(marker);
			<%
				}
			}
		%>
	}
	
	function viewAreas() {
		  	var numTiles = 1 << map.getZoom();
	  	<%
			List<Area> areaList = new ArrayList<Area>();	  		
 
	  		areaList = alienServicesLocal.allAreas();
	  		
			for(Area ar : areaList){
				double x = ar.getTileX();
				double y = ar.getTileY();
				int squareId = ar.getSqaureId();
				String coveredInd = ar.getCoveredInd();
				if(coveredInd.equalsIgnoreCase("Y")){
				
					%>									
					var pixelCoordinate = new google.maps.Point(
					    Math.floor(<%= x%> * TILE_SIZE),
					    Math.floor(<%= y%> * TILE_SIZE));
					//TILE_SIZE/2 is added to move the pixel to middle of the tile
					var worldCoordinate = new google.maps.Point(
							(pixelCoordinate.x + TILE_SIZE/2) / numTiles,
							(pixelCoordinate.y + TILE_SIZE/2) / numTiles);

					var projection = new MercatorProjection();
					var tileLatLng = projection.fromPointToLatLng(worldCoordinate);	
					//http://google.com/mapfiles/kml/paddle/A.png
					//https://mcsense.googlecode.com/files/alien.png
					var iconBase = 'http://maps.google.com/mapfiles/kml/pal5/';
					var marker = new google.maps.Marker({
				       position: tileLatLng,
				       map: map,
				       icon: iconBase + 'icon13.png'
				    });
				    marker.setTitle("Square "+<%= squareId%>+" Covered");
				    aliens.push(marker);
					<%
			
				}
			}
		%>
	}
	
	function viewPlayers(map,bound) {
		var i = 0;
		aliens = [];
	  	<%
			List<SensorReading> playerList = new ArrayList<SensorReading>();	  		
	  		 
	  		playerList = alienServicesLocal.allRecentReadings();
			for(SensorReading sr : playerList){
				double lat = 0.0;
				double lng = 0.0;
				if(sr!=null){
					lat = sr.getGpsLat();
					lng = sr.getGpsLng();
				} 				
				int userID = sr.getUserId();
				if(lat != 0.0 && lng != 0.0) {
			%>				
					var loc = new google.maps.LatLng(<%= lat%>,<%= lng%>);
					//http://google.com/mapfiles/kml/paddle/A.png
					//https://mcsense.googlecode.com/files/alien.png
					var iconBase = '../images/';
					var marker = new google.maps.Marker({
				       position: loc,
				       map: map,
				       icon: iconBase + 'player.png'
				    });
				    marker.setTitle("Player "+<%= userID%>);
				    bound.extend(loc);
				    aliens.push(marker);
			<%
				}
			}
		%>
	}
	
	function viewSentinels(map,bound) {
		var i = 0;
		aliens = [];
	  	<%
			List<Sentinel> sentinelList = new ArrayList<Sentinel>();	  		
	  		 
	  		sentinelList = alienServicesLocal.allSentinels();
			for(Sentinel s : sentinelList){
				double lat = 0.0;
				double lng = 0.0;
				if(s!=null){
					lat = s.getGpsLat();
					lng = s.getGpsLng();
				} 				
				String userEmail = s.getUserEmail();
				 userEmail = userEmail.replace("@", "");
				 userEmail = userEmail.replace(".", "");
				if(lat != 0.0 && lng != 0.0) {
			%>				
					var loc = new google.maps.LatLng(<%= lat%>,<%= lng%>);
					//http://google.com/mapfiles/kml/paddle/A.png
					//https://mcsense.googlecode.com/files/alien.png
					var iconBase = '../images/';
					var marker = new google.maps.Marker({
				       position: loc,
				       map: map,
				       icon: iconBase + 'sentinel.png'
				    });
				    marker.setTitle("Player "+"<%= userEmail%>");
				    bound.extend(loc);
				    aliens.push(marker);
			<%
				}
			}
		%>
	}
	
	function hideMarkers() {
	    for (var i = 0; i < aliens.length; i++) {
	    	aliens[i].setMap(null); //Remove the marker from the map
	    }
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
  
  var coordInfoWindow = new google.maps.InfoWindow();
  coordInfoWindow.setContent(createInfoWindowContent());
  //coordInfoWindow.setPosition(njit);
  coordInfoWindow.open(map);

  google.maps.event.addListener(map, 'zoom_changed', function() {
    coordInfoWindow.setContent(createInfoWindowContent());
    coordInfoWindow.open(map);
  });
  
  createPolygon(njit1,njit2,njit3,njit4,map);
  
  var bound = new google.maps.LatLngBounds(njit1,njit2,njit3,njit4);

  viewAliens(map,bound);
    viewPlayers(map,bound);
  viewSentinels(map,bound);
  viewAreas();
  google.maps.event.addListener(map, 'zoom_changed', function() {
      if (map.getZoom() == 21) {
    	  viewAliens(map,bound);
    	    viewPlayers(map,bound);
  			viewSentinels(map,bound);
    	  viewAreas();
      }
      else {
          hideMarkers();
      }
  });
  
//add a click event handler to the map object
  google.maps.event.addListener(map, "click", function(event)
  {
      // place a marker
      placeAlien(event.latLng);
  });
  
  //map.fitBounds(bound);
}

function placeAlien(location) {
    var iconBase = '../images/';
	var marker = new google.maps.Marker({
       position: location,
       map: map,
       icon: iconBase + 'alien.png'
    });

    // add marker in markers array
    aliens.push(marker);

    //call server and post the alien
    var numTiles = 1 << map.getZoom();
	  var projection = new MercatorProjection();
	  var worldCoordinate = projection.fromLatLngToPoint(location);
	  var pixelCoordinate = new google.maps.Point(
	      worldCoordinate.x * numTiles,
	      worldCoordinate.y * numTiles);
	  var tileCoordinate = new google.maps.Point(
	      Math.floor(pixelCoordinate.x / TILE_SIZE),
	      Math.floor(pixelCoordinate.y / TILE_SIZE));

    //document.forms["myForm"].submit();
    saveAlienAjax(tileCoordinate.x, tileCoordinate.y);
    //submitAlien({'action':'add', 'test':'alien', 'tileX':tileCoordinate.x,'tileY':tileCoordinate.y});
}

function submitAlien(params) {
    var form = document.createElement("form");
    form.setAttribute("method", "get");
    form.setAttribute("action", "http://localhost:8080/PlaysWEB/ControlServlet");
 
    //Move the submit function to another variable
    //so that it doesn't get overwritten.
    form._submit_function_ = form.submit;
 
    for(var key in params) {
        if(params.hasOwnProperty(key)) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);
 
            form.appendChild(hiddenField);
         }
    }
    
    document.body.appendChild(form);
    form._submit_function_();
}

function saveAlienAjax(x, y) {
	var xmlhttp;
	if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function() {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
	    var tempResp=xmlhttp.responseText;
	    }
	};
	var url = 'http://mcsense.njit.edu:10080//PlaysWEB/ControlServlet?action=add&test=alien&'; 
	url = url + 'tileX='+x+'&tileY='+y;
	//alert(url);
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
  <b><big>Alien vs NJIT game</big></b>
<br>
<br>
<i>Enter Alien ID:</i>
<br>
<form name="alien" action="../ControlServlet" method="post">
<p align="left">Alien ID:
<input name="alienId" type="text" size="15" value="">
<input type="submit" name="submit" value="Shoot the alien"></p>
</form>
<i>Note: Zoom to level 21 to see the aliens.</i>
<br>
    <div id="map-canvas"></div>
  </body>
</html>