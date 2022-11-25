package com.lunchwb.vo;

public class MenuVo {
	//////////////////// menu table ////////////////////
	private int menuNo;
	//private int menu2ndCateNo;
	private String menuName;
	private String menuEtc;
	/* join해서 사용 */
	//private int menu1stCateNo;
	
	
	
	//////////////////// food2ndCategory table ////////////////////
	private int menu2ndCateNo;
	//private int menu1stCateno;
	private String menu2ndCateName;
	
	//////////////////// food1stCategory table ////////////////////
	private int menu1stCateno;
	private String menu1stCateName;
	
	
	//생성자
	public MenuVo() {
	}

	
	// 음식 대분류
	public MenuVo(int menu1stCateno, String menu1stCateName) {
		this.menu1stCateno = menu1stCateno;
		this.menu1stCateName = menu1stCateName;
	}

	// 음식 세부분류
	public MenuVo(int menu2ndCateNo, int menu1stCateno, String menu2ndCateName) {
		this.menu2ndCateNo = menu2ndCateNo;
		this.menu1stCateno = menu1stCateno;
		this.menu2ndCateName = menu2ndCateName;
	}

	// 음식메뉴
	public MenuVo(int menuNo, int menu2ndCateNo, String menuName, String menuEtc) {
		this.menuNo = menuNo;
		this.menu2ndCateNo = menu2ndCateNo;
		this.menuName = menuName;
		this.menuEtc = menuEtc;
	}

	
	//메소드 - gs
	public int getMenuNo() {
		return menuNo;
	}


	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}


	public String getMenuName() {
		return menuName;
	}


	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}


	public String getMenuEtc() {
		return menuEtc;
	}


	public void setMenuEtc(String menuEtc) {
		this.menuEtc = menuEtc;
	}


	public int getMenu2ndCateNo() {
		return menu2ndCateNo;
	}


	public void setMenu2ndCateNo(int menu2ndCateNo) {
		this.menu2ndCateNo = menu2ndCateNo;
	}


	public String getMenu2ndCateName() {
		return menu2ndCateName;
	}


	public void setMenu2ndCateName(String menu2ndCateName) {
		this.menu2ndCateName = menu2ndCateName;
	}


	public int getMenu1stCateno() {
		return menu1stCateno;
	}


	public void setMenu1stCateno(int menu1stCateno) {
		this.menu1stCateno = menu1stCateno;
	}


	public String getMenu1stCateName() {
		return menu1stCateName;
	}


	public void setMenu1stCateName(String menu1stCateName) {
		this.menu1stCateName = menu1stCateName;
	}

	@Override
	public String toString() {
		return "MenuVo [menuNo=" + menuNo + ", menuName=" + menuName + ", menuEtc=" + menuEtc + ", menu2ndCateNo="
				+ menu2ndCateNo + ", menu2ndCateName=" + menu2ndCateName + ", menu1stCateno=" + menu1stCateno
				+ ", menu1stCateName=" + menu1stCateName + "]";
	}
	
}
