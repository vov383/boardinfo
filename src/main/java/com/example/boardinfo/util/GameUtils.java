package com.example.boardinfo.util;

public class GameUtils {

    //배열로 받은 값들을 ',' 로 구분한 문자열로 합친 것의 맨마지막 ',' 제거하는 메소드
   public static String removeLastChar(String str) {
        if (str == null || str.length() == 0) {
            return str;
        }
        return str.substring(0, str.length() - 1);
    }
}
