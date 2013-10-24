<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/WEB-INF/googlemaps.tld" prefix="googlemaps" %>    
<!DOCTYPE html>

<%@page import="java.util.ArrayList"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
</style>
<title>Insert title here</title>
<script type="text/javascript"
      src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDjZPZFiASvf0OEQ3cvzTSUqKkrR3ljRfY&sensor=false">
</script>
<script type="text/javascript">
      var map;
      function initialize() {
        var myOptions = {
          center: new google.maps.LatLng(40.741762,-74.177524),
          zoom: 8,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map_canvas"),
            myOptions);
        viewTaskMap();
      }
      
	  function viewTaskMap() {
		//var taskNum = document.forms[0].taskId.value;
		//window.location.replace("/Maps.jsp?taskNum="+taskNum);
		//window.location.reload();
	  	var i = 0;
	  	var bound = new google.maps.LatLngBounds();
		
		if(i == 0){
			var njit1 = new google.maps.LatLng(40.744721,-74.179841);
			var marker = new google.maps.Marker({
		       position: njit1,
		       map: map
		    });
		    marker.setTitle("NJIT");
		    bound.extend(njit1);
		    
		    var njit2 = new google.maps.LatLng(40.742689,-74.173361);
		    var njit3 = new google.maps.LatLng(40.738754,-74.175442);
		    var njit4 = new google.maps.LatLng(40.740819,-74.181815);
		    bound.extend(njit2);
		    bound.extend(njit3);
		    bound.extend(njit4);
		    
		  	map.setCenter(njit1);
		  	map.setZoom(19);
		}
		map.fitBounds(bound);
		//}
	  }
	  
</script>
</head>
<body onload="initialize()">
<br><br><br><br>
<b><big>Map Services</big></b>
<br><br>
<div id="map_canvas" style="width:50%; height:50%"></div>
<br>
<a href="http://www.mappingsupport.com/p/gmap4.php?q=https://mcsense.googlecode.com/files/polygon-simple.kml&ll=40.741738,-74.177588&z=17&t=m&coord=utm">NJIT targeted area</a>
<br>
<P><A HREF=/PlaysWEB/login.jsp>back to Task Screen</A>
</body>
</html>