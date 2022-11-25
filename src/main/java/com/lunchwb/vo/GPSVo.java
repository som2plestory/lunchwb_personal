package com.lunchwb.vo;

public class GPSVo {

	private double gpsX;
	private double gpsY;
	private String address;
	
	public GPSVo() {
		
	}
	
	public GPSVo(double gpsX, double gpsY, String address) {
		this.gpsX = gpsX;
		this.gpsY = gpsY;
		this.address = address;
	}


	public double getGpsX() {
		return gpsX;
	}


	public void setGpsX(double gpsX) {
		this.gpsX = gpsX;
	}


	public double getGpsY() {
		return gpsY;
	}


	public void setGpsY(double gpsY) {
		this.gpsY = gpsY;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	@Override
	public String toString() {
		return "GPSVO [gpsX=" + gpsX + ", gpsY=" + gpsY + ", address=" + address + "]";
	}
	
}
