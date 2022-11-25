package test;

public class VisitedEx {
	public static void main(String[] args) {

		for (int i = 1; i <= 100; i++) {

			// 1월
			for (int k = 1; k <= 31; k++) {
				
				// 주말 제외
				if (k == 1 || k == 2 || k == 8 || k == 9 || k == 15 || k == 16 || k == 22 || k == 23 || k == 29 || k == 30 || k == 31) {
					continue;
				}
				
				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);
				
				int menuNo = 0;
				
				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/01/";
				if (k < 10) {
					str += "0" + k;
					
				} else {
					str += k;
					
				}
				str += "','YYYY-MM-DD'));";
				
				System.out.println(str);
				
			}
			
			// 2월
			for (int k = 1; k <= 28; k++) {
				
				// 주말 제외
				if (k == 1 || k == 2 || k == 5 || k == 6 || k == 12 || k == 13 || k == 19 || k == 20 || k == 26 || k == 27) {
					continue;
				}
				
				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);
				
				int menuNo = 0;
				
				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/02/";
				if (k < 10) {
					str += "0" + k;
					
				} else {
					str += k;
					
				}
				str += "','YYYY-MM-DD'));";
				
				System.out.println(str);
				
			}
			
			// 3월
			for (int k = 1; k <= 31; k++) {
				
				// 주말 제외
				if (k == 1 || k == 5 || k == 6 || k == 9 || k == 12 || k == 13 || k == 19 || k == 20 || k == 26 || k == 27) {
					continue;
				}
				
				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);
				
				int menuNo = 0;
				
				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/03/";
				if (k < 10) {
					str += "0" + k;
					
				} else {
					str += k;
					
				}
				str += "','YYYY-MM-DD'));";
				
				System.out.println(str);
				
			}
			
			// 4월
			for (int k = 1; k <= 30; k++) {
				
				// 주말 제외
				if (k == 2 || k == 3 || k == 9 || k == 10 || k == 16 || k == 17 || k == 23 || k == 24 || k == 30) {
					continue;
				}
				
				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);
				
				int menuNo = 0;
				
				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/04/";
				if (k < 10) {
					str += "0" + k;
					
				} else {
					str += k;
					
				}
				str += "','YYYY-MM-DD'));";
				
				System.out.println(str);
				
			}
			
			// 5월
			for (int k = 1; k <= 31; k++) {
				
				// 주말 제외
				if (k == 1 || k == 5 || k == 7 || k == 8 || k == 14 || k == 15 || k == 21 || k == 22 || k == 28 || k == 29) {
					continue;
				}
				
				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);
				
				int menuNo = 0;
				
				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/05/";
				if (k < 10) {
					str += "0" + k;
					
				} else {
					str += k;
					
				}
				str += "','YYYY-MM-DD'));";
				
				System.out.println(str);
				
			}
			
			// 6월
			for (int k = 1; k <= 30; k++) {
				
				// 주말 제외
				if (k == 4 || k == 5 || k == 6 || k == 11 || k == 12 || k == 18 || k == 19 || k == 25 || k == 26) {
					continue;
				}
				
				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);
				
				int menuNo = 0;
				
				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/06/";
				if (k < 10) {
					str += "0" + k;
					
				} else {
					str += k;
					
				}
				str += "','YYYY-MM-DD'));";
				
				System.out.println(str);
				
			}
			
			// 7월
			for (int k = 1; k <= 31; k++) {

				// 주말 제외
				if (k == 2 || k == 3 || k == 9 || k == 10 || k == 16 || k == 17 || k == 23 || k == 24 || k == 30 || k == 31) {
					continue;
				}

				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);

				int menuNo = 0;

				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/07/";
				if (k < 10) {
					str += "0" + k;

				} else {
					str += k;

				}
				str += "','YYYY-MM-DD'));";

				System.out.println(str);

			}
			
			
			// 8월
			for (int k = 1; k <= 29; k++) {

				// 주말 제외
				if (k == 6 || k == 7 || k == 13 || k == 14 || k == 20 || k == 21 || k == 27 || k == 28) {
					continue;
				}

				int storeNo = (int) Math.floor((int) (Math.random() * 4022) + (int) 1);

				int menuNo = 0;

				String str = "insert into visited values(SEQ_VISITED_NO.nextval,";
				str += i + ",";
				str += (int) Math.floor((int) (Math.random() * 4) + (int) 1) + ", ";
				str += storeNo;
				str += ", ";
				str += menuNo;
				str += "," + "to_date('2022/08/";
				if (k < 10) {
					str += "0" + k;

				} else {
					str += k;

				}
				str += "','YYYY-MM-DD'));";

				System.out.println(str);

			}

		}
	}

}
