package com.example.boardinfo.util;

import com.example.boardinfo.model.game.dto.artist.ArtistDTO;

import java.util.List;

public class GameUtils {

    //리스트로 받은 값을 String 타입으로 변환
    public static String listToStr(List<String> list){
        StringBuilder strbuilder = new StringBuilder();
        String result = "";

        //리스트를 출력후 합침
        for(String str : list){
            strbuilder.append(str).append(",");
        }
        result = strbuilder.toString();

        if(result.indexOf("(unknown)") != -1)
            return null;
        else
            return result;
    }

    //위의 listToStr메소드의 String값의 맨마지막 ',' 제거하는 메소드
   public static String removeLastChar(String str) {
        if (str == null || str.length() == 0) {
            return str;
        }
        return str.substring(0, str.length() - 1);
    }

    //클라이언트로부터 input받은 값들의 null값 여부 확인후 null이면 (unknown)을,
    // 아니면 ',' 기준으로 나눈 배열로 리턴하는 메소드
    public static String[] checkNullnSplit(String str){
        //null값이 들어오면
        if(str == null || str == ""){
            str = "(unknown)";
        }
        //배열로 리턴
        return str.split(",");
    }


}
