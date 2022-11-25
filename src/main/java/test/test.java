package test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;

public class test {

	public static void main(String[] args) throws ParseException {
		//String ipt = "2022-08-21T09:24:08.908Z";
		String ipt = "2022-08-21T09:24:08";

		Date date  = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(ipt);
		System.out.println(date.toString());
				
	}

}
