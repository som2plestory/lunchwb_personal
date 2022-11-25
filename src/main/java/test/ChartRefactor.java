package test;

public class ChartRefactor {
	
	public static void main(String[] args) {
			
		String str = "{&quot;type&quot;"
				+ ":&quot;pie&quot;"
				+ ",&quot;data&quot;"
				+ ":{&quot;labels&quot;"
				+ ":[&quot;20대 이하&quot;,&quot;30대&quot;,&quot;40대&quot;,&quot;50대&quot;,&quot;60대 이상&quot;]"
				+ ",&quot;datasets&quot;"
				+ ":[{&quot;label&quot;:&quot;&quot;,&quot;backgroundColor&quot;"
				+ ":[&quot;#4e73df&quot;,&quot;#1cc88a&quot;,&quot;#36b9cc&quot;,&quot;#f6c23e&quot;,&quot;#e74a3b&quot;]"
				+ ",&quot;borderColor&quot;"
				+ ":[&quot;#ffffff&quot;,&quot;#ffffff&quot;,&quot;#ffffff&quot;,&quot;#ffffff&quot;,&quot;#ffffff&quot;]"
				+ ",&quot;data&quot;:[&quot;974&quot;,&quot;1531&quot;,&quot;1231&quot;,&quot;1682&quot;,&quot;453&quot;]}"
				+ "]},&quot;options&quot;"
				+ ":{&quot;maintainAspectRatio&quot;:false,&quot;legend&quot;"
				+ ":{&quot;display&quot;:false,&quot;labels&quot;"
				+ ":{&quot;fontStyle&quot;:&quot;normal&quot;}},&quot;title&quot;:{&quot;fontStyle&quot;:&quot;normal&quot;}}}";
		str = str.replaceAll("&quot;", "\"");
		
		System.out.println(str);
		
		
		
		
		
		
	}

}
