package com.ruanko.utils;


import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {
	
   //判断是否为空
	public static boolean isEmpty(String str){
		if("".equals(str)|| str==null){
			return true;
		}else{
			return false;
		}
	}
	//判断是否非空
	public static boolean isNotEmpty(String str){
		if(!"".equals(str)&&str!=null){
			return true;
		}else{
			return false;
		}
	}
    //判断时间格式是否正确  eg. YYYY-MM-DD
	public static boolean isRightTime(String str){
		 String datePattern1 = "\\d{4}-\\d{2}-\\d{2}";
	     String datePattern2 = "^((\\d{2}(([02468][048])|([13579][26]))"
	             + "[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|"
	             + "(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?"
	             + "((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?("
	             + "(((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?"
	             + "((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))";
	     if ((str != null)) {
	         Pattern pattern = Pattern.compile(datePattern1);
	         Matcher match = pattern.matcher(str);
	         if (match.matches()) {
	             pattern = Pattern.compile(datePattern2);
	             match = pattern.matcher(str);
	             return match.matches();
	         }
	         else {
	             return false;
	         }
	     }
	     return false;
	 }

	


}





