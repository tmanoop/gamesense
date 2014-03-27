<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sensing Game Admin</title>
</head>
<body>
Welcome!!

<form name="test" method="get" action="ControlServlet">
<br><br>
<table align="center"><tr><td><h2>Test Screen</h2></td></tr></table>
<table width="300px" align="center" style="border:1px solid #000000;background-color:#efefef;">
<tr><td colspan=2></td></tr>
<tr><td colspan=2> </td></tr>
  <tr>
  <td><b>Action</b></td>
  <td><input type="text" name="action" value=""></td>
  </tr>
  <tr>
  <td><b>Test</b></td>
  <td><input type="text" name="test" value=""></td>
  </tr>
  <tr>
  <td><b>TileX</b></td>
  <td><input type="text" name="tileX" value=""></td>
  <td><b>TileY</b></td>
  <td><input type="text" name="tileY" value=""></td>
  </tr>
  <tr>
  <td></td>
  <td><input type="submit" name="Submit" value="Submit"></td>
  </tr>
  <tr><td colspan=2> </td></tr>
</table>
</form>
</body>
</html>