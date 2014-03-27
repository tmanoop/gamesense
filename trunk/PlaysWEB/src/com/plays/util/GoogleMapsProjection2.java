package com.plays.util;

import java.text.DecimalFormat;

public final class GoogleMapsProjection2 
{
	public static final int ZOOM = 13;
    private final int TILE_SIZE = 256;
    private Point _pixelOrigin;
    private double _pixelsPerLonDegree;
    private double _pixelsPerLonRadian;

    public GoogleMapsProjection2()
    {
        this._pixelOrigin = new Point(TILE_SIZE / 2.0,TILE_SIZE / 2.0);
        this._pixelsPerLonDegree = TILE_SIZE / 360.0;
        this._pixelsPerLonRadian = TILE_SIZE / (2 * Math.PI);
    }

    double bound(double val, double valMin, double valMax)
    {
        double res;
        res = Math.max(val, valMin);
        res = Math.min(val, valMax);
        return res;
    }

    double degreesToRadians(double deg) 
    {
        return deg * (Math.PI / 180);
    }

    double radiansToDegrees(double rad) 
    {
        return rad / (Math.PI / 180);
    }

    public Point fromLatLngToPoint(double lat, double lng, int zoom)
    {
        Point point = new Point(0, 0);

        point.x = _pixelOrigin.x + lng * _pixelsPerLonDegree;       

        // Truncating to 0.9999 effectively limits latitude to 89.189. This is
        // about a third of a tile past the edge of the world tile.
        double siny = bound(Math.sin(degreesToRadians(lat)), -0.9999,0.9999);
        point.y = _pixelOrigin.y + 0.5 * Math.log((1 + siny) / (1 - siny)) *- _pixelsPerLonRadian;

        int numTiles = 1 << zoom;
        point.x = point.x * numTiles;
        point.y = point.y * numTiles;
        return point;
     }

    public Point fromPointToLatLng(Point point, int zoom)
    {
        int numTiles = 1 << zoom;
        point.x = point.x / numTiles;
        point.y = point.y / numTiles;       

        double lng = (point.x - _pixelOrigin.x) / _pixelsPerLonDegree;
        double latRadians = (point.y - _pixelOrigin.y) / - _pixelsPerLonRadian;
        double lat = radiansToDegrees(2 * Math.atan(Math.exp(latRadians)) - Math.PI / 2);
        return new Point(lat, lng);
    }

    public static void main(String []args) 
    {
        GoogleMapsProjection2 gmap2 = new GoogleMapsProjection2();
        
        Point point1 = gmap2.fromLatLngToPoint(40.5311376, -74.5671738, ZOOM);
        DecimalFormat df = new DecimalFormat("#");
        
        System.out.println(df.format(point1.x)+"   "+df.format(point1.y));
        Point point2 = gmap2.fromPointToLatLng(point1,ZOOM);
        System.out.println(point2.x+"   "+point2.y);
    }
}
