<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.plays.model.Alien"%>
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
var tiles=[];
var myJsonTiles;
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
		  polygonNJIT = new google.maps.Polygon({
		    paths: njitCoords,
		    strokeColor: '#FF0000',
		    strokeOpacity: 0.8,
		    strokeWeight: 2,
		    fillColor: '#FF0000',
		    fillOpacity: 0.35
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
				double lat = al.getNextGpsLat();
				double lng = al.getNextGpsLng();
				int alienID = al.getAlienId();
				if(lat != 0.0 && lng != 0.0) {
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
	
	function loadTileCoord() {
		var numTiles = 1 << map.getZoom();
	  	<%
			List<Area> areaList1 = new ArrayList<Area>();	  		
 
	  		areaList1 = alienServicesLocal.allAreas();
	  		
			for(Area ar : areaList1){
				double x = ar.getTileX();
				double y = ar.getTileY();
				int squareId = ar.getSqaureId();				
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
				var tile1 = new Object();
				tile1.squareId = <%= squareId%>;
				tile1.latLng = tileLatLng;
				tiles.push(tile1);
				<%
			}
		%>
		myJsonTiles = JSON.stringify(tiles);
		alert(myJsonTiles);
		document.forms["tiles"]["myJsonTilesValue"].value = myJsonTiles;  
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
  coordInfoWindow.setPosition(njit);
  coordInfoWindow.open(map);

  google.maps.event.addListener(map, 'zoom_changed', function() {
    coordInfoWindow.setContent(createInfoWindowContent());
    coordInfoWindow.open(map);
  });
  
  createPolygon(njit1,njit2,njit3,njit4,map);
  
  var bound = new google.maps.LatLngBounds(njit1,njit2,njit3,njit4);

  viewAliens(map,bound);
  viewAreas();
  google.maps.event.addListener(map, 'zoom_changed', function() {
      if (map.getZoom() == 21) {
    	  viewAliens(map,bound);
    	  viewAreas();    	  
      }
      else {
          hideMarkers();
      }
  });
  
  //map.fitBounds(bound);
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
  <b><big>Alien vs NJIT Game Admin Screen</big></b>
<br>
<br>
<br>
<form name="tiles" action="../ControlServlet" method="post">
<input type=hidden name="myJsonTilesValue"/>  
<input type="submit" name="submit" value="Load Tile Coordinates" onclick="return loadTileCoord();">
</form>
<i>Note: Zoom to level 21 to see the aliens.</i>
<br>
    <div id="map-canvas"></div>
  </body>
</html>