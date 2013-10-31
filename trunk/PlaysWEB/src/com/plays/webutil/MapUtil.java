package com.plays.webutil;


public class MapUtil {

	private static final int TILE_SIZE = 256;
	private static final double ZOOM = 21;
	

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public static void fromTileToLatLng(int x, int y){
		double pixelCoordinateX = Math.floor(x * TILE_SIZE);
		double pixelCoordinateY = Math.floor(y * TILE_SIZE);
		double numTiles = Math.pow(2, ZOOM);
		//		TILE_SIZE/2 is added to move the pixel to middle of the tile
		double worldCoordinateX = (pixelCoordinateX + TILE_SIZE/2) / numTiles;
		double worldCoordinateY =(pixelCoordinateY + TILE_SIZE/2) / numTiles;

//			var projection = new MercatorProjection();
//			var tileLatLng = projection.fromPointToLatLng(worldCoordinate);	
	}
}
